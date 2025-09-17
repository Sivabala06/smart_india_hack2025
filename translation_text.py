# Install dependencies (run once in your environment):
# pip install googletrans==4.0.0-rc1 deep-translator

from googletrans import Translator
from deep_translator import GoogleTranslator
import time

def translate_to_english(text, retries=3, delay=2):
    """
    Tries to translate using googletrans first with retry,
    then falls back to deep-translator if googletrans fails.
    """
    translator = Translator()

    for attempt in range(retries):
        try:
            translated = translator.translate(text, src='auto', dest='en').text
            return post_process_english(translated)
        except Exception as e:
            print(f"⚠️ googletrans failed (Attempt {attempt+1}/{retries}): {e}")
            if attempt < retries - 1:
                print(f"⏳ Retrying in {delay} sec...")
                time.sleep(delay)
            else:
                print("🔄 Falling back to deep-translator...")
                try:
                    translated = GoogleTranslator(source='auto', target='en').translate(text)
                    return post_process_english(translated)
                except Exception as e2:
                    return f"❌ Translation failed: {e2}"

def post_process_english(text):
    """
    Converts raw translated text into a more formal,
    professional, and medically appropriate tone.
    """
    text = text.strip()
    if text and not text[0].isupper():
        text = text[0].upper() + text[1:]
    
    replacements = {
        "I have": "The patient reports",
        "I am having": "The patient is experiencing",
        "My": "The patient's",
        "Me": "The patient",
    }
    for k, v in replacements.items():
        text = text.replace(k, v)
    
    return text

# --------------------------
# Interactive Mode
# --------------------------
if __name__ == "__main__":
    print("🌐 Punjabi/Hindi ➜ Polished English Translator (type 'exit' to quit)")
    while True:
        raw_text = input("\n📝 Enter text: ")
        if raw_text.lower() in ["exit", "quit"]:
            print("👋 Exiting translator. Goodbye!")
            break
        
        english_text = translate_to_english(raw_text)
        print("🔍 Original Text:", raw_text)
        print("✅ Polished English:", english_text)
