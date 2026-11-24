using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{


    public float speed;
    float horizontalAxis;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        horizontalAxis = Input.GetAxis("Horizontal");
        Vector3 direction = new Vector3(horizontalAxis, 0, 0);
        transform.Translate(direction * speed * Time.deltaTime);
    }
}
