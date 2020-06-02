From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Date: Tue, 2 Jun 2020 14:39:14 +0200
Message-ID: <20200602123914.GA3360525@ulmo>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgFBMjR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:39:17 -0400
Content-Disposition: inline
In-Reply-To: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Heiko Stuebner <heiko@sntech.de>, David Wu <david.wu@rock-chips.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
> The way state->enabled is computed is rather convoluted and hard to
> read - both branches of the if() actually do the exact same thing. So
> remove the if(), and further simplify "<boolean condition> ? true :
> false" to "<boolean condition>".
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I stumbled on this while trying to understand how the pwm subsystem
> works. This patch is a semantic no-op, but it's also possible that,
> say, the first branch simply contains a "double negative" so either
> the !=3D should be =3D=3D or the "false : true" should be "true : false".
>=20
>  drivers/pwm/pwm-rockchip.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

I've applied this. Irrespective of any feedback David would have this is
correct and a nice simplification.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSHEACgkQ3SOs138+
s6EIvA//U+YBcRa/yOWyp3jhnv0UxhIHPIk4tcP1l5N4cNtnj23Y4VCdv7baJM4M
k2OKqKanjnp0AROTYeu150CEqI+xXuND8W7PKRIcCTLkS2Gy7WBXh1ezlCRupzyH
uYRPi+PY5ZkX/owSFRy+2Ii5o5ywzPc5aH6hqsLfKGzkUrJA/wFsTH85JfmEwwTu
8WOYkvO8zGqaA32B5Orx42x4jH020aa/PorZsl1WXjEnqN7zc0Ke5CZxZN/puoE+
YuTAqG9NDMFiZzkeN2vHbuafUyBk0zSRiz+/1KTkKPnubJ0bLncbCZRonghCCCNV
3hWEB8Fm5pP9mo5Ht4q6Z4or2JkuWbcu3IwyE9SrerLtcTbkbCqaU3kkvKFm72Gy
QN2iUJiGHk4i7PYqNEAWfQ9i16U7+2nbb6rroHiHcKR8G1boWJcwyg6dwVto5uUN
47k4J8HTAZBsDysAH4GVavggIig9WwMMqprGhVRA7CLhMtp5i/g+9fyN6OmxmwAO
9N4Sxs/ScWdReU63b0DbWRdEQa9OVK0BWz13uoESETZcfeH9ggZpY2EDBQ96KRY5
cG9Ka88WfHJJ7qth/PcHsu94fFnbcPkZeca16guCWoYIi5SdCJeDuPVfbjV1xn9T
Fu/bhyvbAecyGACpTbIwZb5DhtT4HYr0IX4Q4mJ8PfM8b0BdR4o=
=OaiW
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
