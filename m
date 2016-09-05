From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 2/3] pwm: Add MediaTek MT2701 display PWM driver support
Date: Mon, 5 Sep 2016 08:36:05 +0200
Message-ID: <20160905063605.GC3532@ulmo.ba.sec>
References: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
 <1468225089-28576-3-git-send-email-weiqing.kong@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6797804600092970878=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1468225089-28576-3-git-send-email-weiqing.kong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Weiqing Kong <weiqing.kong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--===============6797804600092970878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2016 at 04:18:08PM +0800, Weiqing Kong wrote:
> Use the mtk_pwm_data struction to define different registers
> and add MT2701 specific register operations, such as MT2701
> doesn't have commit register, needs to disable double buffer
> before writing register, and needs to select manual mode
> and use PWM_PERIOD/PWM_HIGH_WIDTH.
>=20
> Signed-off-by: Weiqing Kong <weiqing.kong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 99 +++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 80 insertions(+), 19 deletions(-)

Applied. This had a few inconsistencies in how things were parameterized
and I fixed those up. Please check that everything still works as
expected.

Thanks,
Thierry

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzRJTAAoJEN0jrNd/PrOhhqkQAIz1aXXfKn8v+hOToKHehZB+
T/HxxLK6HDy9ItMnKJ7qZ90OnAiuY+6d+J+u688fD33QN4veMcYOGV28hG1w4Val
S+Y6Ivv43FVTV7Naj19Mug6NtmTT2YibLaGyttG1I55oDCwXgRhCy54noMHZj+qz
EjC5xS0rXOgocfTokbxknZ+xItS7G1whg2zPx02Bo7Pktwhp1gQulGJ9Z1Fd8piR
dzzzsq98dwO/FM78RFRX4lRG9SDWQ9uI+NPUqcOWpXtFPf2v9qarSZz2opGvEFnd
Fb6RFM2WIvq4Vv7aC+24nvQe41pm/hb2o9yMujXsnPSlqsfHvKuqaTdrq2uqnC9+
nplKH3jVeG+jgRYOK9vTLu+KFaIDDpmlgz5+R1wgipjh9UtoUM2DUKd6+2jCVVjb
ectJAPX1fIzwma1s0as7gW2VTpZShpAdCtsHWeBwMICpZBLkv1TXkObi4uL03yY5
qeBwqmq3Oat/J1iCBSm6XTWBIXTSGNFw/Qlcx+pnRURxOrqjr2WoWJpD5st74Okr
hnF152D1R6Q0cVjihvUpE5U/lrMTInWV8/qeKm2q8cwV0t+qCw7+RFME4vGluF0m
NoK6r81E7nUm9Xy3NHC1HfFmPnLZ8RUYl5vdsA303lLTtxk/19EcVTtsyBXm159U
DtT8McLj2Vn4FnOtpR11
=LaiB
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--


--===============6797804600092970878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============6797804600092970878==--
