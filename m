From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Date: Tue, 7 Jun 2016 11:02:18 +0300
Message-ID: <57567F8A.10603@ti.com>
References: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
 <5755664D.5070109@ti.com> <20160607084907.14ffdc03@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aBGTKVr9S59UcVpum8XMionpkD6iXbgl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607084907.14ffdc03@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

--aBGTKVr9S59UcVpum8XMionpkD6iXbgl7
Content-Type: multipart/mixed; boundary="JFpkeGILC0tawt8FFhTx910gbDfLiTahT"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Message-ID: <57567F8A.10603@ti.com>
Subject: Re: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
References: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
 <5755664D.5070109@ti.com> <20160607084907.14ffdc03@ipc1.ka-ro>
In-Reply-To: <20160607084907.14ffdc03@ipc1.ka-ro>

--JFpkeGILC0tawt8FFhTx910gbDfLiTahT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/16 09:49, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> On Mon, 6 Jun 2016 15:02:21 +0300 Tomi Valkeinen wrote:
>> Hi,
>>
>> On 06/06/16 13:44, Lothar Wa=C3=9Fmann wrote:
>>> 'brightness' is usually an index into a table of duty_cycle values,
>>> where the value at index 0 may well be non-zero
>>> (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-lif=
e
>>> examples).
>>> Thus brightness =3D=3D 0 does not necessarily mean that the PWM outpu=
t
>>> will be inactive.
>>> Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D 0' to =
decide
>>> whether to disable the PWM.
>>
>> The binding doc does say:
>>
>>   - brightness-levels: Array of distinct brightness levels. Typically =
these
>>       are in the range from 0 to 255, but any range starting at 0 will=
 do.
>>       The actual brightness level (PWM duty cycle) will be interpolate=
d
>>       from these values. 0 means a 0% duty cycle (darkest/off), while =
the
>>       last value in the array represents a 100% duty cycle (brightest)=
=2E
>>
> So, what should I do, when I need a range of levels that doesn't start
> at 0? E.g. if the brightness is inverse proportional to the PWM duty
> cycle.

That's a question to the PWM/backlight maintainers, but I think in the
addition of your patch, the binding doc needs to be changed, as it
doesn't hold true after your patch.

 Tomi


--JFpkeGILC0tawt8FFhTx910gbDfLiTahT--

--aBGTKVr9S59UcVpum8XMionpkD6iXbgl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVn+LAAoJEPo9qoy8lh71XfcP/iD0AxZD8UubwRZ5a37SXaUh
82QyLGYlKRv38iqOSr/r3/AeXDpDTOmhwZbyBUKHa0gZLTBP1x3G85VNeHsQQMam
0dXUbcvospBDX6xMChjQGsG0l+fWVS6rX1XkXFvVF3CmYL4UdoHnptIG9toocZSR
VDTFt17MHxHubQdUZxJjWHsGaEH+PrSIGXgHPJWWlVg4zGUR4ms3nQk9udair6YW
pGZ2PvK8qWVX0l81xCqatwQ0XwQxY7AYVUvlsnI3kprvnRMrxR03XOT63G1Gb+/Z
Hh9Re1pFE9/4jc0V9Umn31nm6oJmZAJ0lPzqX2y9PKqEHGTCSfruv6we5npGF44Y
0JZDRyDnuB5BO75eoVMCRjSIR69HltoC+utl2yZQcw1HiOXULPZLlNHUgt37Njpm
g4uFYTD4cGgfqBMznZ3849qbYMj2s4+HkcQKVpXmOHwKGNWqfGmey4+cJIp3H5Gk
7xhmcV1ALWACIf7bMa0G3hrH2RKwk247FzG4hMpXwQ0FMfd1Anp6z8YELmGj6CvN
F0xj2G7wjU/BBnYt6oMe9QlFh2oXoy/K0wmhxhlxnDR3ldtBQWWDqPDYIHFFj/iV
7PfYVgSVvS1A2HiJqTsIiGY4RzsDDJlurNnUaMPr7QDHI5QEfNqOiKmpB7L0MOgm
N2oICrC3wsd689HC0LGB
=huGB
-----END PGP SIGNATURE-----

--aBGTKVr9S59UcVpum8XMionpkD6iXbgl7--
