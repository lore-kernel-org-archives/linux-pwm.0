From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable mc13xxx-pwm support.
Date: Thu, 28 Nov 2013 16:58:28 +0100
Message-ID: <20131128155827.GD23201@ulmo.nvidia.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
 <1385566771-366-3-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:56852 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab3K1P7O (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 10:59:14 -0500
Content-Disposition: inline
In-Reply-To: <1385566771-366-3-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 04:39:31PM +0100, Denis Carikli wrote:
> The eukrea mbimx53sd has its display backlighgt
>   connected to the pwm of its mc13xxx, so we turn
>   it on.

This is weirdly formatted. Also check the spelling: "backlighgt" ->
"backlight", "pwm" -> "PWM", "eukrea" -> "Eukrea".

Also, perhaps: ", so we enable the PWM driver."

Thierry

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl2gjAAoJEN0jrNd/PrOhuA0QAIlXVZ15BmkezG3B+jP3hjnA
ewnpWFOoE+OumIhWtzZ9+R1a8DjRImI8HiJG2HN439Vq7aef+u6wifDiRLIqyH4V
gVBTnKKJ2gOCWExKlTnMe0dqzcIoe/l7wmiCprbZ880Efepq8r4tIuT/nTQmV9Uy
fp8nWTolEE9rlaifF7BCn/fTIBy/ooKA++n3Ls+zNTXI0V0J+UEKBWItrO83e+Sh
Vx1lIZhuxz86sNGpD2UlAt9ov4aaf7/5eCIZEJu8Iaw8vB9ohC1/GeJpbYGNM/cq
0/bxutZXDu4SpyPeldEQNzwmereyBQFfBGQnZq6pfuUlsS4AS8XNa3AenB0/FS9d
1t+ByJfsmFFQG8eMeYg6utjjvx9TbBYhD49hEnfQll4mYSVI3b9ME5337OQ95jeF
vaLTzqiaZLxMld91QF5kkCAql+nRK6XgzvEWPgEugxgso2r78+vekXvZ83hZ2tYS
Ad2D3c6eEefX4SdBEDQJutyFfEG+kKIv4paVsmbvgRmMkONklC/SYQLS/Sounn25
W8e3tbRo7OmM3q+c2gMa1m9/pFO23y2V8+3nPQEg/6XCsX/4eJmgcmrbb5CJ9vez
mLMkd/Ydq3PNs4B8HbaE4obHY5XbfAVWV74QI9vZ+0O7/apYsGkxkt7pyYugLm1/
+Orn5QwQE1+dvYQfpQeK
=dUKH
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
