From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in
 img_pwm_config
Date: Wed, 20 Mar 2019 12:30:05 +0100
Message-ID: <20190320113005.GB23838@ulmo>
References: <20190307223628.21270-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307223628.21270-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-pwm@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
>=20
> drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
>=20
> The final else if functions as an else; make that explicit so that Clang
> understands that timebase cannot be used uninitialized.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/400
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

Thierry

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySJD0ACgkQ3SOs138+
s6E56A/9F05DPbUM0SbbazEQOwUiPy48Ag9mRyXsXCvhxloijwFNTHSOGJ86C/Hh
wLpYG5t47dqrnFgb3W07M2BGsEH3FyrfYRLrhYgB5M2/7Dc718TWodZfvt6jthOE
1sjFKAg1CHTt/bUNPAarq19l5ENKVrwj52auukodIUeRFQjjst4weFQ4NVmJN2rp
Yh6jHHq9VmGsNUUhw0OiIigXshIg8UQAcINvmzfK5RlAYfbp6/F37/MgBjYluV2u
C2Fb2d6s1V/5u72CdC0MD0lcbTsVZwBGdgcdPTHgW32IpToI6JkDDiIT8rDHteHE
ThVTECSLbrLRDyhFS5W2O0eoMejiiYLh01Is7es0cMXzlW9/sxia8pHdtySnD9lN
5vPT8V47Sfq+v6EvEI5m8i0u4iHdNclB4qe0pMN3pZHH3FsW/VjN4oYt9xkl3Xfm
7feiX5pI1NaVVwQ89kJaqVt/Cwmcy3HDDCmSXzXgeviDGguqnX+VD7O2iyRwPhvi
eaf8hgGrRcyM8EFtOBpz+RBeaVGA8mO3eNdzDNYHa76vdUQcoZz5ApfYgjOOgMfT
qdP864Sdc67xCdKSGxy74WDom3DLZ7OoyIiHJyWz6rbHK49abbCQSH9I7eKYFusl
zW3GxLvKpVzgkyfM4ZvjtV8Bi1YEMcAFBn4HVnzTghZIHXOxrEw=
=xI91
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
