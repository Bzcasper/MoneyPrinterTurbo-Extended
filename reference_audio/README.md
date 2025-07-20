# Voice Cloning with Chatterbox TTS

This directory is for reference audio files used for voice cloning with Chatterbox TTS.

## How to Use Voice Cloning

1. **Add Reference Audio Files**: Place your reference audio files in this directory
   - Supported formats: `.wav`, `.mp3`, `.flac`, `.m4a`
   - File name will become the voice name (e.g., `john.wav` → "john" voice)

2. **Audio Quality Requirements**:
   - **Duration**: 10-60 seconds of clean speech
   - **Quality**: Clear, no background noise
   - **Content**: Single speaker, natural speech (not singing)
   - **Language**: Any language supported by the speaker

3. **Select Cloned Voice**:
   - In MoneyPrinterTurbo UI, select "Chatterbox TTS" as TTS server
   - Choose the cloned voice from the dropdown (named after your file)
   - The system will automatically use your reference audio for voice cloning

## Example Files

To get started, you can add audio files like:
- `narrator.wav` - Professional narrator voice
- `casual.mp3` - Casual conversational voice  
- `british.wav` - British accent voice
- `storyteller.flac` - Storytelling voice

## Tips for Best Results

- **Consistent Quality**: Use the same recording setup for all files
- **Clear Speech**: Avoid mumbling, background noise, or music
- **Natural Pace**: Normal speaking speed works best
- **Multiple Takes**: You can have multiple reference files for the same voice
- **Test Different Voices**: Try different reference audios to find what works best

## Technical Details

- Chatterbox TTS uses your reference audio to clone the voice characteristics
- The cloned voice will maintain the tone, accent, and speaking style of the reference
- Processing happens locally on your machine (no data sent to external servers)
- First generation with a new voice may take longer as models load

## Troubleshooting

If voice cloning isn't working:
1. Check file format is supported (.wav, .mp3, .flac, .m4a)
2. Ensure audio is clear and contains speech
3. Try shorter reference audio (10-30 seconds)
4. Restart MoneyPrinterTurbo after adding new files
5. Check logs for any error messages

For support, see the main MoneyPrinterTurbo documentation. 