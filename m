From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] pwm : pwm-vt8500 - Undo preparation of a clock source.
Date: Tue, 25 Jul 2017 13:44:12 +0200
Message-ID: <20170725114412.GC22355@ulmo>
References: <1493971214-3763-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493971214-3763-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux@prisktech.co.nz, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 01:30:14PM +0530, Arvind Yadav wrote:
> Undo preparation of a clock source, if vt8500_pwm_probe is not
> successful.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/pwm/pwm-vt8500.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAll3LwwACgkQ3SOs138+
s6EaKQ//QLBrfT7Ty2q288lqNdm8b6Q0OzuTcnXEwTgVkYU6fmrqZYFRqtDoOPw4
3Ex41PbtoRr3zqMULUbnwtvaV6OT2E9CuDX6NqQgHrBfO6TdFjQ+UBUfnsVk3u19
B/zQ4h8qLWLtSC0wBOWVTxSzWn0Ki7+9EICuRZuLrG/T7NOnK7iSU8+xS2SBkb1F
lE0jNg1kSQbIiH2fHrwWK4Eg977HfikQ8ZIAeqWX0Sjlm5xEajpGBmQSUIowJMgt
OqrZplQoqsrnTfRVeXmFJOcmDZCe41fWOIpAQCfO/NlnVvcrRfCz99sfD4B9vUn6
D2NMcLlgw2ZNgcotW2LUsNBYyQ/ALIImPGJ5JJD1IOxgXChaEsuWm2AEfPAojhed
CHz6Wq29gpl6HXRNCusumNnfRrbgimKSv9WYZOSnoD7OSLO0GV/OuLwOXL6bbOoA
BYV7uoDKcq1ynp4YMtUFd7j63vQD5s8YXCfGqxwWqblB+7dyAeWitXOPEqgd3zEj
DFJglaqo1+en7KP679OWJqQ9hI7byvtD8/65TUu0cPgjpIhEsMbFGxCwy7Uc97cE
juOxyCBe/6pmbySE3WsqiWJiQbFEMvwVNH/VtGMeXPWQqzDRQSJeVSBYeQF7k1xc
E9AdOKaETibixA4UscpFmu/RkBRMVsv37ZeWFhw+7JOM/3lo+Lk=
=i3Xe
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
