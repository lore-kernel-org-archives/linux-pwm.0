From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH v4 7/8] pwm: Add dummy pwmchip for orphan pwms
Date: Tue, 17 Oct 2017 14:40:31 +0200
Message-ID: <20171017124031.GA27983@ulmo>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-8-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:54430 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbdJQMkf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Oct 2017 08:40:35 -0400
Content-Disposition: inline
In-Reply-To: <20171017101624.12506-8-jeffy.chen@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, heiko@sntech.de, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org, broonie@kernel.org, seanpaul@chromium.org, linux-pwm@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 06:16:23PM +0800, Jeffy Chen wrote:
> When the pwm driver is unbound while the pwm is still requested, the
> pwm core would not actually remove the pwmchip(return -EBUSY instead).
>=20
> So it would hold some references to the invalid resources(e.g. pwmchip).
>=20
> And the customer who requested the pwm would have those references too,
> and may crash the kernel when trying to access them later.
>=20
> Add a dummy pwmchip, and assign orphan pwms to it to avoid that.
>=20
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>=20
> Changes in v4:
> Fix compile warning.
>=20
> Changes in v3:
> Assign orphan pwms to dummy pwmchip instead of adding device link in the
> customer driver.

What happened to this? Device links were specifically designed to avoid
situations like these.

A dummy PWM chip doesn't seem like the right solution to this.

Thierry

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnl+jwACgkQ3SOs138+
s6F4bA//f1Oa17yHcoiFXf8sGe7NkBSBgbUxcRy++zDpmIHNBiH39xz5JiN3Hag0
Yy/z1+YPEgdt0Wj6rQQtTwtKqwPYb1ntUrMRMAJjuyoyTILCoTpoTLCgOSSaK4UT
d8eD2CB9ZACk7LYKN33bfm60zUgXPFswUlBJ2gFdC9171XpsyFruqFE/RzIpEzLp
93C8IPhGwuONWCU/9k2MaQoh1krxAvpjeW++/4UR6a7Ai7Jy8c8K/7RyHJQb+nef
TLZBUuhvlFNbkaKwgvdm6R8OVO2NcP4UiLkzZRITXwDtUR04HunpBM4o1S9WzEFq
yf35ntOBkbIt3KE/HSeW+68yoZAyezIWmypejWaTGHv/xmRzLf80kQKBW7h4lghn
CnAm//euwaqYU7tUOomyjwDd5Z4uuKPz8d0GvMqz0AXI/+qfSSoSNx76YyGQYqEK
RBXa+kfeeakllo4Yq6zE7v8aaJ06OZ4DhmqXC4/kXE3ps0l66jXg8ejSlNn1ZTlA
QtOSEdSIiiTLeoN780RWMey5voDmYamck/gTITGGcCL8Ya4xHvgRMjZBvZrqWvNU
rzdYoj02sxP6lm9HXXoCDI/rCPkA/kN5/U2jq63KDvfDtzgbbExxwrByo9yIDx1K
EAygnEWrXCY7nqt+wf4Nnuf65rDLvbdN/aPAI3IHCZWs4R6ghBA=
=8X8s
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
