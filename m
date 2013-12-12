From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation
 with COMPILE_TEST
Date: Thu, 12 Dec 2013 13:37:30 +0100
Message-ID: <20131212123728.GJ11524@ulmo.nvidia.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:43866 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3LLMiq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Dec 2013 07:38:46 -0500
Content-Disposition: inline
In-Reply-To: <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 02:18:33AM +0100, Laurent Pinchart wrote:
> This helps increasing build testing coverage.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqa4IAAoJEN0jrNd/PrOh0qEP/jM/p14kYO0YYlOzTomJGkZ0
wdXC2pvRg2VmKcyvrQh3g66HbcBhJt6FDqqoIt5Qwr33sQFWSrxm3lUewGT+mpMS
1PuzJgsD1VGiIqsu39/tS78shNgJ7nozPp051jPdpLLnj24MAGWS8AYdEtB2UNcs
lTwNe74CfNszPeQi4z0sNhP0mPYt8Z7Tm8hXeStQfjQNb8x1UVj7iI6dtib7equq
DRt5WCTZ6l+PRx9eoho3tf6JWj/7GNPAHIYlpnaMRIXmTPtNGHADgRxnQNEQSxuN
pdmv6/5GK8Xi17fgQrcf5kG6muCB+lBDd9zSv81UoCOlNOP8bW/sVl123UVi1dFY
brQ4ahhkr6U6fSNpjpIqOnWG6SrRTYTr8c4m4+v2Xe6IxFTYlWjAsEEp+s0uacvt
+dgmKlO1zybnnfnWVEY9DDPFJ3XB9w9BOPOhNfffjzOzQt+KBMpY1nwxRWvAX8xY
WV0W+mXfTUJAnFGh0BrE+qzvSz97igYCXB6m6MvoS7LUKEYqJoJQWSniLlzWIi65
1t6/sOGk7Fgz+4panhnSIM7AasOMFlQU9ciWZm/+yNUfA6GAbUKZeBFDZxaCPAiQ
NOmCj3AxEVEcsp8zZTBUd+qFuBuLgdHN7m1b+oWDIXdIh5cmrbul5Jbv6hKFyXJE
CcSkKLKsds0xXRGZSSip
=JZNx
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
