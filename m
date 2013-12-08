From: randy <lxr1234@hotmail.com>
Subject: [exynos4412]How to test a pwm device, is there a test program?
Date: Mon, 9 Dec 2013 01:22:02 +0800
Message-ID: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from blu0-omc4-s37.blu0.hotmail.com ([65.55.111.176]:39195 "EHLO
	blu0-omc4-s37.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800Ab3LHR1E (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Dec 2013 12:27:04 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The dts for my board tiny4412 is ready, in my board, the pwm 0 is
connect to a buzzer. I want to test whether it works, but I don't know
any test util. As I have a oscillograph, there is no problem for me to
measure whether the output is correct.
Thanks
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJSpKq6AAoJEPb4VsMIzTzizgMH/0uYcf0oMc6Hvc4X8zmMFJRm
QKgoPv4y0v0jQmN59ZANQC4AkqU3PiUEeirBufYTEFEn0EYtSKSOGj+fcRy6tXUq
22FibOy/S3zdrFM3kt3XiXHhGjJyiMlLgHoOWk0KnkSbXT99/c3wDtspLtcwTa4j
r7iUx7kqdQd+o6Q05ahMcMr+33jMVLDinr/ixTJsvXWa0dLJmYa3vMkVKGa8aOZb
jlwwJ8Nj3VzQcVfjiVdJ90OGshAQ/1auF7DGWHKcWX4IoLuAtKZPYZrhq8nno9Cy
xDVA0uO+zUX1iCTQxSHNw269K1uQT+XdGusN6cZ/JUw9+9r+VI2dIzO/e/ASk+8=
=PfFs
-----END PGP SIGNATURE-----
