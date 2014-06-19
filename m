From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM
 on the B2020 Rev-E
Date: Thu, 19 Jun 2014 12:59:27 +0200
Message-ID: <53A2C28F.1080007@st.com>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>	<1403103172-19856-4-git-send-email-lee.jones@linaro.org>	<20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>	<20140619092042.GB26560@lee--X1> <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pqjER9VX6Q2lQG3rsnDrcg9HRWeE28jtA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, srinivas.kandagatla@gmail.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

--pqjER9VX6Q2lQG3rsnDrcg9HRWeE28jtA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 06/19/2014 12:12 PM, Peter Griffin wrote:
> Hi Lee,
>=20
>>> Why are you only enabling this for rev-E board?
>>
>> Purely for testing purposes, as it's the only board I have.  If
>> anyone has the other revisions and would be happy to test the driver
>> for me then great.
>=20
> Ok that's what I suspected.
>=20
> If you tell me how, I can test on a Rev C board. But as there are sever=
al other=20
> revisions I think checking the board schematics would be the quickest w=
ay forward.

Only Rev C & E are in the wild now, so checking these two boards will
be enough.

Thanks,
Maxime

>=20
>>> If you make the stih415 DT PWM nodes part of this series as well, the=
n=20
>>> assuming there is no good reason to the contary, the PWM could=20
>>> be enabled for both stih415/6 in the common stih41x-b2020 DTS file wh=
ich
>>> is also included by rev-E (assuming that PWM wiring is not some rev-E=
 specific
>>> thing).
>=20
> Can you add the stih415 bindings in V2 as well?
>=20
> regards,
>=20
> Peter
>=20
> _______________________________________________
> Kernel mailing list
> Kernel@stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
>=20


--pqjER9VX6Q2lQG3rsnDrcg9HRWeE28jtA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJTosKPAAoJEMo4jShGhw+JX7QP/0Fk44XXnazRCpk2cbDCbtZd
2LRmSwbys3M0Re22DoMqxj7aoct9Gt6KfwMCf7AJqa+0qNO+6QEGC3oTTweEGa3y
Way6+zd7vy1o9NklPgsm00yD5GzhwM5IW7Gz5AplnStvGLzMb37BTquggaE7e6Wg
zsJYOkylfIODpZA8i8s7th7IebLFsmd5HAZdrvnvHji2DOpxr58bnV1ZPK7Qvweb
mChY+BjiR02PfSaRh1heleMvV7raU9f+o3EvND3aZUF171UIMv6TrRmZ/2GP1Zp7
xpT3bIg9xhZ/K6yo5PugTIbaUD2o9+nTcnSJV62EhEmvGkGD5wVhnoNavOlU5x6r
G4znapR31t/06yCB3qubNK6YNPkgBqE/P6AjH3clRI6flwAFGjDEB9XzXmBir1DZ
4p8qsO2Vwdg1/ZuDrdQg/bKBe4rSIHj0EykiH102DPaPIi2I2O2fqDpvOyUqG3dg
QGGnQFqVRQf+jeCrXBz8kO7sqtARN4YDYA3GLP+UeCeY9W5Bq2Zx0QQPw7I36naH
xgeZ+T1co8wStRAsluHSNDdRLiHQztxmQctcFXhj70w30ZiSWduYPlWT+tK9PFgy
YGBfGRibwoxyrl5Dd+rM+2dL9Hlz4yk5nLTNULyc1mVoFN/rlZ9SULwQM6kertBl
aGuCktPG26r4p90S2+g/
=B8eR
-----END PGP SIGNATURE-----

--pqjER9VX6Q2lQG3rsnDrcg9HRWeE28jtA--
