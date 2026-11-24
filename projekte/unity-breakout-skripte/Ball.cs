using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Ball : MonoBehaviour
{

    public Transform paddle;
    public float maxSpeedBall;
    Rigidbody2D rb;

    public TextMeshProUGUI scoreText;
    public GameObject restartGame;

    public GameObject winningGame;



    int score = 0;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();

        // CheckObstacles();
    }

    // Update is called once per frame
    void Update()
    {
        if (transform.position.y < paddle.position.y)
        {
            Time.timeScale = 0;
            transform.position = new Vector3(0, 0, 0);
            rb.velocity = Vector3.zero;
            restartGame.SetActive(true);
        }
        if (rb.velocity.magnitude > maxSpeedBall)
        {
            rb.velocity = Vector3.ClampMagnitude(rb.velocity, maxSpeedBall);
        }

        CheckObstacles();
    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        if (other.gameObject.CompareTag("obstacles"))
        {
            Destroy(other.gameObject);
            score += 1;
            scoreText.text = score.ToString();
        }
    }

    public void RestartGame()
    {
        Time.timeScale = 1;
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }

    public void CheckObstacles()
    {
        if (GameObject.FindGameObjectsWithTag("obstacles").Length == 0)
        {
            winningGame.SetActive(true);
            Time.timeScale = 1;
            // SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
    }

}
