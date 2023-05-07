 String getComment(int index) {
    List<String> comments = [
      "Rocket is always listening to this one...",
      "This song brings back memories of that fight on Knowhere.",
      "Ah, this song always makes me think of that adventure on Xandar.",
      "I remember Groot grooving to this during that prison break.",
      "The lyrics of this song really speak to me on a personal level.",
      "This song is giving me serious Guardians of the Galaxy vibes.",
      "This tune is perfect for flying through space in the Milano.",
      "This song is gonna be on repeat in my helmet for a while.",
      "This song takes me back to my childhood on Earth.",
      "This song is giving me serious Awesome Mix Vol. 4 vibes.",
      "The guitar solo in this song is out of this world.",
      "I can't wait to add this song to my ever-growing playlist of epic tunes.",
      "The energy in this song makes me want to take on the entire Kree army by myself.",
      "I can't wait to crank up the volume on this song and jam out with Groot.",
    ];

    return comments[index % comments.length];
  }