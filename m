From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 07/11] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Date: Sat, 21 Sep 2019 02:21:49 +0200
Message-ID: <20190921002149.GB86019@mithrandir>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568933351-8584-8-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2019 at 06:49:07AM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
>=20
> This adds a property "num-pwms" in example so that we could
> specify the number of PWM channels via device tree.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v6:
> Follow reviewers's comments:
> - The subject should indicate this is for Mediatek
>=20
> Changes since v5:
> - Add an Acked-by tag
> - This file is original v4 patch 5/10
> (https://patchwork.kernel.org/patch/11102577/)
>=20
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

You failed to address Rob's questions repeatedly and I agree with him
that you can just as easily derive the number of PWMs from the specific
compatible string. I won't be applying this and none of the patches that
depend on it.

Thierry

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2FbRoACgkQ3SOs138+
s6Gohw/+NufS4BYOFKibVi7zlUVi/rDMwlkt6F4pkhnyohrqgpTCBy9F9h2ogtxO
QywrdiuhNuV49zxKHNgpXVQFmYpaUVuCsNaGHGZegyF182jcYtTraRfGm50PJf/F
x/ppM52eCnkM8gMIq+/ZQ3WYmpjhoFw5746ToZyy4m8mhXmQZqAwVFBOfce70jI6
Q8g6TNP93ayNLFVf4Hd2UNTN6d17l7sa8LKwWJqRulbH/PwnD/8seCkdBmEwcbdy
0qPYAkxAkGLfdN9mn+vf3sk+1N+qaLS0ich28ev/y/Ece8ey+RIHy894iZUko0is
j68nY8DRsf9S5YeZ6RfMQQbAiEaA+LWOLckX44XgQTQRrgAGBOsmfLgZVGQVrKCq
oQVl9Fg7FX30ZsIkNTAkpEX8bERLjj7XkpUvJLo+SYKA0xzrA34RM+RGTXGxA82O
7mb8nuqyPXdiVtWkcrne+IiggZoix3DBBsv9ujKNo2rYsSP3yEJiZpki/4GNsdhR
kKv17KdvVoP51ls+wUvxzI6Kr/DZeYIkrcWWNjNdig/XTzlyUeXdUsq9jYWz4UA3
MS9/0ZQSYdkuhIpcQPDduLx562SN6sykZi9cgcclULK7RqUv+rtlAg2zZty2WXtZ
TpxE5tnTnXlMHiaC7YnKbleL6K4l9qmoALx/oUvq9CZTJxEEHJY=
=P6kM
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
