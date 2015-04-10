From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to control the pwm-fan
Date: Fri, 10 Apr 2015 13:25:52 -0400
Message-ID: <87h9snvqsf.fsf@gmail.com>
References: <20150408104415.07e1c821@amdc2363> <20150408153214.GA15942@roeck-us.net> <CANAwSgSD52sDpP7NH2hhiZX-=LZF6Qo-X3enqsqM+5XAMfyP=Q@mail.gmail.com> <20150408165351.GA22846@roeck-us.net> <CANAwSgQbNV9QZ2bFGk6g+RyWW6f5iW4e8ii_5rJ4srv02L=L_Q@mail.gmail.com> <CANAwSgRSxj9frUHRXh3JwD+bpnFrj8WkpDMKHZn-OPmuCEgP7w@mail.gmail.com> <1428667201.22057.20.camel@collabora.co.uk> <CANAwSgQHi2-i8xHn+X+KTGg8HFpe6SPgkuSvuApJP3342N8+zQ@mail.gmail.com> <5527CB78.4040002@roeck-us.net> <1428672601.22057.25.camel@collabora.co.uk> <20150410135844.GA20147@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150410135844.GA20147@ulmo.nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, Anand Moon <linux.amoon@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pwm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thierry Reding <thierry.reding@gmail.com> writes:

> On Fri, Apr 10, 2015 at 03:30:01PM +0200, Sjoerd Simons wrote:
>>=20
>> Yes/no/maybe :). Imho this is something to clarify in the pwm API
>> documentation. As currently all it says is:=20
>>   "pwm_disable - stop a PWM output toggling",=20
>>=20
>> Which is what the exynos driver does.=20
>>=20
>> Thierry, could you clearify what the intention is here? I'm happy to
>> prepare a pwm driver patch if needed to solve this?
>
> I think the safest thing to do is for users to do both. You call
> pwm_config() with a zero duty cycle to make it clear what the status is
> that you want. Then you call pwm_disable() to state that you don't need
> the output signal anymore, so that any clocks needed by the PWM can be
> stopped. Doing so gives the driver the most information and should make
> the user more resilient against any possible quirks in drivers.
>
It would be great if the documentation were more clear on this matter
regardless. This is something I can imagine having to spend substantial
amounts of time Googling whereas a simple note in the documentation would
have removed all ambiguity.

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVKAehAAoJEHPt6ejPuu8BJNQH/jeNzpQjLNqqhX/I94cQ5O0H
wmteEl4B6GGvbWjxQrrIeC2ehezj8lle3ZfeABkpG/W3mLkxig1sN1w8Nbl52iwR
BUD0/daUXUctAh+505B530Na9HlVdqRmsNCTbDivQPkKJ4nTM9Hpn18iSB+sFXEh
CDLlYWOrm7hf60kCPo7mtT6glfG5Nfl9edp3gqs+/VHG7tXX6t4GLjZsldB5ZWGY
Hxb6XpjoukNt3NHU6dUPIRDEqEzGRbEh8cyj90b+qocAntcJ2s0qPHluJU2QYxiK
EdocDkhd6xzi++CtN7SBO676q3dIdWzOHXyXzluBbJVGKk3H+aHucMbPlLg1/ts=
=bVp/
-----END PGP SIGNATURE-----
--=-=-=--
