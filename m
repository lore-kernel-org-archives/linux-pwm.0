From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 07/12] dt-bindings: pwm: pwm-mediatek: add a property
 "num-pwms"
Date: Thu, 26 Sep 2019 00:50:05 +0200
Message-ID: <20190925225005.GB8115@mithrandir>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
 <1569421957-20765-8-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1569421957-20765-8-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 10:32:32PM +0800, Sam Shih wrote:
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
> Changes since v10:
> 1. Follow reviewers's comments:
> - derive the number of PWMs from the specific compatible string
[...]
> + - num-pwms: the number of PWM channels.
[...]

Why is num-pwms still there if you derive it from the compatible string?
I guess I must not have made myself clear. Please drop this.

Also, as I mentioned earlier, I've already applied the patches from v9
that were suitable. Please take a look.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2L7xwACgkQ3SOs138+
s6EKQBAAkjKF3mGlNiF2VtYjBYbi8012ySVpqf2IVmJEdG1xulyW6cUqSPW50ZRu
biZJTXPgRLuLLIt9/vt5h/XKjvXevhTlhgv3FCWTl+tgqpgo9xhDpFANSZksadH9
EsVp5NE1/jgTvdPa/0iYJiDHzF6pg/+zNRweveinqkVcM5mfICWwK42vZVOHx23b
O+Nzhgr/D1ExmA4W6BUQ8BdCnCyVr8OAL7eYiRWRDwC9esDg34fuq9/irwcMo+mc
MZE5ieoQmMvs4GOYjOdNy4G5OrBlfadzfpU95xtshQTUyv+w+TX5bj9mWpkZWlgX
ah5DydkbX7fgR0BMnD8K0UqFr8GOgiJOmQ3VU1Q/orjaw/k0byjAQ3DoEjzGUoS+
hAy+zt5H+IwVmMO+U9giO66xOWZLKBLa1loJJpSJ0ly0mYCO5KsJx1digyBAc1l5
DELrYLXnLaXvxQfibweSxiKbCpOeJrsY5REaU5cmbasIFGSYRtvvI6/emTe+YUgW
IPQ6s3CgvLVw/F+IvZle7CAfuhvltywTksUsYLsJYDjszGhuhYQiM26yjSzE62eM
ykgQxzfDn/SN1H/cqEQgoTgMmUSxBJNa6SKYrRSlTuyWkj/74pWQdzP9hzUwi7c7
moqU0o8poSC29OA665w+DJ4AMeQ8QSGNm+ZOO9SpmGBY8752amg=
=QjmR
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
