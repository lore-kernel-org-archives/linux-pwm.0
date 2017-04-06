From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: rockchip: State of pwm clock should synchronize
 with pwm enabled state
Date: Thu, 6 Apr 2017 15:10:47 +0200
Message-ID: <20170406131047.GA8438@ulmo.ba.sec>
References: <1488366655-31387-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488366655-31387-1-git-send-email-david.wu@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: boris.brezillon@free-electrons.com, briannorris@chromium.org, heiko@sntech.de, dianders@chromium.org, b.galvani@gmail.com, caesar.wang@rock-chips.com, huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 07:10:55PM +0800, David Wu wrote:
> From: "david.wu" <david.wu@rock-chips.com>

You might want to set up git to use the correct author.

> If the pwm was not enabled at uboot loader, pwm could not work for clock
> always disabled at pwm driver. The pwm clock is enabled at beginning of
> pwm_apply(), but disabled at end of pwm_apply().
>=20
> If the pwm was enabled at uboot loader, pwm clock is always enabled unless
> closed by ATF. The pwm-backlight might turn off the power at early suspen=
d,
> should disable pwm clock for saving power consume.
>=20
> It is important to provide opportunity to enable/disable clock at pwm dri=
ver,
> the pwm consumer should ensure correct order to call pwm enable/disable, =
and
> pwm driver ensure state of pwm clock synchronized with pwm enabled state.

Please always use all-caps for abbreviations suchs as "PWM". I've fixed
up the commit message and applied this to for-4.11/fixes.

Thanks,
Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmPlcACgkQ3SOs138+
s6GuThAAjkNFwJg7Vj++BySJEV8bp7CE6s0JHqqnmi5EABd2z9DMDRxKc9LkVZss
mJfhtDSCopqAjJCZt/CPoTtffVh80uIgDVFaQEsbRrLL/9VnCcEJyATuJ2yUGwM6
qwxCBT+DktETgiSfR6qEMdxea8TC6Y5/N1iET168aO9ZVLgrdkjwXMgVMKlVdgya
WBpuKgivGS0xMYBSbVzWg4r65K4Ghy/mfrJGJJdiWqWEV2u3bBlVl9uZoKKVP9hH
QZyPVK4S4fBzItXfNGQ9OE9Emf3X8mt/5EBomXq0u8vxHGnKw7CgVEob1WI/UgQK
ArfDqs0Bk9JHyVb4Gx7waKyYvhRAM0Ob9NRTyZ/8q2T8rfwQlFIplXS/bMKWdY+g
EhXD4AdPg4apxgIFeZN20LOU2Uer0ruX9r3hFs3FxXVzM/t4pPfeIP58poZa7cgx
wtP1WZDi3ATx2Bir8BTcD5ra7Pc0u+eVbkYZUw/zH43wWdXkMit+1FFc8m8Ap53L
HlnNEfwwLfK4Tj4u+M7zvv+VcfR3GmHJ4mAqZTPxgebdz/mvVlwpJxJf60HXeph9
okrFrv1ztjJXUWaGgWu5S+wtgKwumPz5Ytd8sT98T/ojA1UHc2EpfkAREagvWulU
QUjXBViSb3P46yE2fRIGf94SiVejhPtdwfQfa7H9pYBCh2kJ1iU=
=7Q3b
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
