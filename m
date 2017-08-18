From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 5/7] pwm: rockchip: Use same pwm ops for each IP
Date: Fri, 18 Aug 2017 17:44:14 +0200
Message-ID: <20170818154414.GG18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:41:28PM +0800, David Wu wrote:
> Just use the same pwm ops for each IP, and get rid of the
> ops in the struct of rockchip_pwm_data, but still define
> the 3 different rockchip_pwm_data to use common interface
> for each IP.
>=20
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 147 ++++++++++++---------------------------=
------
>  1 file changed, 38 insertions(+), 109 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXC04ACgkQ3SOs138+
s6GMYw//XD6CVOG2Cd85F2nr09Z6VciVRXyXucILE8oglWfKqgHesPVnjqS6KlOi
mgkSV7vp+HbjU2ZD38vtg0Cq0IaLS0iJTlluxRhNjx0gFgbgOKn3ZkRnlEf8059v
OnFiYGWYe20Q1uDF3FoN7vYZ/thyjvXNSAy5cnKq1HhWSCZ4OjGOycgFQYL6CvPw
dBAwA5h521SZfOTJrsWxm0sQ/XN7McUT5u1NtP0Z43tXz2Y8PTsJqY8YTIcFVAnE
5b/l/8OqhJsHrosRVgvLGndLrdu5y95kSJLpRSDgRpQab7YG7e8+wFhd+gdhbYQK
cS8ruBITcqF+nTsusfcVeolDzntSqcYGdy2HdVg4bUvnWML6uo1hzs7UJPoo+ibg
CDVW6rKdULnsBoXAQHVBCXI1Bie7alzY3REo3Evq42pjvaDS04IBpA0cFGR9Vblt
hnOT9oiSJP5zbf/rhoxbcjnDQRZMvlYyi0wZno9ni5n4VXG0hFwdBTnB6r/meGEz
4qI9EnPSqP6x9J2Pq0wwlKz4JXV3STpDw5Eqm62cTYd1TJG56XD6uYqCs6XAAKfJ
xJ7fjfhL0cQeuNlz08sPrk9+BIJMoY7syKed37YDWiBkYqqVuz+icc7BLGZw0ebL
Qpft4mnd5Ctwhb02VO8piEabDhWjXYXwI+PXmkLEUzxy6UcHznk=
=kOF1
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
