From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Date: Mon, 24 Sep 2018 13:53:01 +0200
Message-ID: <20180924115301.GV21032@ulmo>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3a/Z8KDuKqDOIvAo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: stefan.wahren@i2se.com, gohai@sukzessiv.net, hsweeten@visionengravers.com, gottfried.haider@gmail.com, loic.pallardy@st.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--3a/Z8KDuKqDOIvAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
> regression with multiple pwm chip. It creates a new entry in
> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
> - 1st time export will create an entry in /sys/class/pwm/pwmX
> - when another export happens on another pwmchip, it can't be created
> (e.g. -EEXIST)
>=20
> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm=
):
> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
>=20
> Example on stm32 (stm32429i-eval) platform:
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
>=20
> $ cd /sys/class/pwm/pwmchip0/
> $ echo 0 > export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
>=20
> $ cd /sys/class/pwm/pwmchip4/
> $ echo 0 > export
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> ...Exception stack follows...
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/sysfs.c | 1 -
>  1 file changed, 1 deletion(-)

Can we come up with an alternative that allows us to have both? We want
uevent and proper sysfs creation, or is that not possible?

Thierry

--3a/Z8KDuKqDOIvAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluo0BwACgkQ3SOs138+
s6EHUw//XihD4PTiYRbp2BgEONYQVv9olCZpDV9XeDuhhEp7ejTEp9cDDzfuT/nJ
gMEWrVvzykDiL+x4YwknSNOif9ID4dctHsgky8obwHjkwCnbL7JpZg7z3wf6JVpP
ZGx2TJzKP5bxnogpdT8pPf6o0rraaGKfsF6VjNk/Br/Q1+Fok5dQlOVq+koK+awi
B5MeVTp7HkeM28H0GKB+W949cnm+c151atfUaqUTDiNr5m3sPddt66YOoAdacp2g
HRyn5SoXgifc8g/BiOLCbdJ6jkVE8/J024nmX5ocVjKmp3RPpbmNZcSP/UYfhCps
wApPJWlQZi6Mcog+oDVkHSgwYnSe8qpjTS5i1IYXedxt53DMpG+lb4W39+ri6AQ9
erpzlVS54Q96AUjNEy5pTFWz2bjCLbWqthw5N1eQdQ03k6N0AiMioWo/mMOlFdIq
TZ0OR9fERejWbdqmPwEJmFp++ArM1FGgezWoBOUXtSeu7tg1f/dTI1SHHdWN2n4Y
caozOKJkZvDcDlUNEtx46aRFCQsXz24D3B98Hc1ke8VW7JJcSY2O0gFfq/oppy4J
6IfDznypkzTX7OkroXxZrzxm9ScpoUitW3q+fyMNhpScnyx9Run4/0kDFLEpfKpi
ITterfo9MsyQqvwROIVWIv5i3QtwfaWBXrU1/u5IhcHIFzjOrPs=
=wDcO
-----END PGP SIGNATURE-----

--3a/Z8KDuKqDOIvAo--
