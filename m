From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 2/3] pwm: add MediaTek display PWM driver support
Date: Mon, 5 Oct 2015 17:59:10 +0200
Message-ID: <20151005155910.GE17612@ulmo>
References: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
 <1439882875-19596-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439882875-19596-3-git-send-email-yh.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com
List-Id: linux-pwm@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 03:27:54PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173 and MT6595.
> The PWM has one channel to control the brightness of the display.
> When the (high_width / period) is closer to 1, the screen is brighter;
> otherwise, it is darker.
>=20
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/pwm/Kconfig        |   11 +++
>  drivers/pwm/Makefile       |    1 +
>  drivers/pwm/pwm-mtk-disp.c |  232 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mtk-disp.c

Applied, thanks.

Thierry

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEp5NAAoJEN0jrNd/PrOhCzMQAInzpcrS3//ZFr9i1iEqGduo
i9i++ZavAePINtmjE3WvKNPd9ac7ypOTT5mWNEpUinvkWVog0SP1dLE8/fX3dPNu
akG+pnrRuglhP3NnIK9/367S4fFuZLRXyFfjBpYAYICIzyHVX/4MVzvwKhQaVivN
Ul3IN3H7gxlCFt4nSHDwLB/4h6AywrNZeemE9is8JL5DrNsJzdXLygpQZYacBCx6
HaCAo5Lz0ZpvmN7pSBbodhgPVEH0LF+2TtgoIQeu6z+5OaCMC1xmUettmaIdIDyO
mQVThdDqAZ5l9VSjS+o75wsLqHVFlX/mNVMhYPxi7wK99E5ENuMxuoTeNGEzL/HR
5HwbaXdwTBHaaLytCOYj+1g252crdLdpAquvYMIVd+bCIntlwUbb7UIXDiOXVna0
VcoeBnCRnkO6qBabH5yHGUsiaEdHRUCoh5/RPlUfhfEfY0jY7sT6za6SS19RAf5Z
lwlwyG5+6beZQgMd4XybyhFg7mXQfihMHF2HSyEdA+qsKNC02XLp+POeUrrOfqNU
nhP66TzENkMSGQzv19JAT0hya/7YeNpalOorKxNgyyCZQ2qlEr1qcf49uIdAiSM+
3tEbZ+WKvCx48nj80S6MICogXUXKykzNpWTxgOhhcHWojX9FApIgkxF8qic3wJfj
mqq48c1zucNhIWna5JdF
=zGIF
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
