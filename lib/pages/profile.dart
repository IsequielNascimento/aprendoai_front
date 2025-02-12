import 'package:aprendoai_front/themes/app_themes.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Appthemes.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildConquistasSection(context),
          const SizedBox(height: 20),
          _buildOfensivaDosAmigos(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Appthemes.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          const SizedBox(height: 10),
          const Text(
            "PSI",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _ProfileStat(value: "3", label: "Coleções"),
              SizedBox(width: 20),
              _ProfileStat(value: "16", label: "Passos"),
              SizedBox(width: 20),
              _ProfileStat(value: "299", label: "Questões"),
              SizedBox(width: 20),
              _ProfileStat(value: "14", label: "Dias"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConquistasSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Conquistas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  // Navegar para a tela de conquistas completas
                },
                child: Text("ver mais",
                    style: TextStyle(color: Appthemes.primary)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _AchievementIcon(icon: Icons.emoji_events),
              _AchievementIcon(icon: Icons.star),
              _AchievementIcon(icon: Icons.military_tech),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfensivaDosAmigos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ofensiva dos amigos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _FriendCard(name: "Turing", score: 43),
              _FriendCard(name: "John", score: 20),
              _FriendCard(name: "Anne", score: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class _AchievementIcon extends StatelessWidget {
  final IconData icon;

  const _AchievementIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Appthemes.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 60, color: Colors.orange),
    );
  }
}

class _FriendCard extends StatelessWidget {
  final String name;
  final int score;

  const _FriendCard({required this.name, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Appthemes.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Appthemes.blueColor,
                child: Text(name[0],
                    style: const TextStyle(color: Colors.white, fontSize: 30)),
              ),
              const SizedBox(height: 5),
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                  ),
                  Text("$score", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
