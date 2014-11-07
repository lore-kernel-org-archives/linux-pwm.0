From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy
 API
Date: Fri, 7 Nov 2014 14:47:36 +0100
Message-ID: <20141107134735.GA31950@ulmo>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:59407 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbaKGNrl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Nov 2014 08:47:41 -0500
Content-Disposition: inline
In-Reply-To: <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2014 at 04:46:26PM +0300, Vladimir Zapolskiy wrote:
> If PWM device is requested by means of legacy API pwm_request(), its
> resources are not freed on module unbind, which may cause an oops on
> access, e.g. by reading /sys/kernel/debug/pwm.
>=20
> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/video/backlight/pwm_bl.c |    4 ++++
>  1 file changed, 4 insertions(+)

Hopefully this can soon go away when all users of the legacy API have
been converted. Until then:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUXM13AAoJEN0jrNd/PrOhPV0P/Ro6JoXbveNYGPOmHjVLRG9A
5sUV5KSU4dkszYcMhQElvarLMvAEnp5CTuRLGdf5Oev0XNZZHTsmdOPc0KqnP5cn
DBT1FrCjbO1TVn/czFDBMk8K5vOzyyXXv7EnQrBhxjg0Nq6SqjaVwWKdis4icizT
mFPEUNWBzDRI93iu2eh3/CbSClzFZ1bkb0AMQb1it/1LoBELRRSd/ywWU67V0yZz
NNVcnnUUwI0quWbKg1g99Z2cuQXNLJylA59rXqBcSeja34ED6awOPObnSoYRln29
lEQ3oMjCiCvC1YhwwAgFxpeX3P5AYcYUtc72OUcqsKa4AKjPla3ZJQCle3sKLD4v
HH3q6t40sZxedh6SRXGF32FcwMnrxd1anpt0fKgxG3FG+ei6VxZ7fGlobfwuSW0c
Ao+cjO5p6NH/bWkl2ED36cbHI4alXET05WEPOgZ3F4g82BO07R5GLtb2m1kZtGps
18BebmBmXLH+lMABPitXKmeTnccv2igmmXHxadwblMvJrna+8KwRvejmoudeF0eS
j+oZTBjUrZDMSlgZckUR2TmfsrRN3549pMXbPv2aebyJJXGIFwZwNzjJGB8JG9dD
W291vTefiH27DYWTKM/KgbaHZHLffW2vNCZ1YnJLa2PwiybJaEMLzIW9Lcoxv/gs
MccTLZKZp+uy5NYjcB+z
=ZXiE
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
