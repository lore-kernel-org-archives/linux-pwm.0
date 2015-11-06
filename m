From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 05/10] pwm: sysfs: do not unnecessarily store result in
 var
Date: Fri, 6 Nov 2015 15:51:38 +0100
Message-ID: <20151106145138.GB8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-6-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445895161-2317-6-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:32:36PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> Use the result of pwm_is_enabled directly instead of storing it first.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPL55AAoJEN0jrNd/PrOhZpcQAKwRnTNz7E9hfX/MdiPB+yGc
nkOWYTTdhkSKp5KBnv4Rqo8KjmTCQGXr9IpSDPjPyT7ebQ+JveddihPaCpCk+ifH
M90IfVV9d4TGrI7kIw8BaWKf2D9kDE0qtO9Ajn/lxOkKDQr4dKWHO0Ll9243S6Ms
5qciIBWwkRqZ3EmWo+Wqx/8Qzqa7nc9NVX4ThxIWSGwtowvrm3Ga9VNlngJYvF+6
3CTMdxFQuNZjlGvfacCYwK5rLnsHItWXq8c1kDXgNoVwJ+T/wSbhOiZI0aqCuW6g
PazX7ct9mFolFqNa+b9BSGu5bZm69e/tt5iBl/SJLmF0dgAnx8Xf41jsxqu8H8lA
nM8lQmuBO4QKmjzGntcM//QRS48Oip85H4rR+eNIy9e1FlZ4NpUyKXKIoT4WChB9
UJTYaYwscBg/Mlrn+6PUpHdls5hWisRdoZ6ISUwfC0k5qJbE76D7M+popZUxboP6
LR+Q/+ADKx5nH1Egdrm2szli4JOwRivpUSkrrB+3WntOhM5b/3c91ikKMGfz2qUv
CEXK1owE8Oe+GAWhb+zl814H24WL1DpSK3o6NM1v4GQu0gmSjmmHK0v8U3SRiy+H
xnR40aq1TCeveJo6jay0tQLb/0by5Mx4WStYUCPrN2gWfz7H2JCd8WFvRa9a5+NG
VnHg5/J7WvNfbYoigoEI
=VDxu
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
