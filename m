From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Date: Mon, 19 Aug 2019 10:10:49 +0200
Message-ID: <76d5c0b8-09d1-cf64-2d83-4982cd517f70@kleine-koenig.org>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
 <20190816204357.GG3545@piout.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4185649363601058837=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190816204357.GG3545@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pwm@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Thierry Reding <thierry.reding@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4185649363601058837==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OpzLNV15XLyGK7w6j36LK6zLUuPvZ42iR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OpzLNV15XLyGK7w6j36LK6zLUuPvZ42iR
Content-Type: multipart/mixed; boundary="3UC7z54i9bPgQE5FgMPA5CLo4ZpV8QPUw";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Message-ID: <76d5c0b8-09d1-cf64-2d83-4982cd517f70@kleine-koenig.org>
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
 <20190816204357.GG3545@piout.net>
In-Reply-To: <20190816204357.GG3545@piout.net>

--3UC7z54i9bPgQE5FgMPA5CLo4ZpV8QPUw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Alexandre,

On 8/16/19 10:43 PM, Alexandre Belloni wrote:
> On 16/08/2019 11:37:48+0200, Uwe Kleine-K=C3=B6nig wrote:
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
>> ---
>>  drivers/pwm/pwm-atmel.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index 42fe7bc043a8..1ddb93db9627 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -7,6 +7,16 @@
>>   *
>>   * Reference manual for "atmel,at91sam9rl-pwm":
>>   *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-b=
it-ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
>> + *
>> + * Limitations:
>> + * - Periods start with the inactive level.
>> + * - Hardware has to be stopped in general to update settings.
>> + *
>> + * Software bugs/possible improvements:
>> + * - When atmel_pwm_apply() is called with state->enabled=3Dfalse a c=
hange in
>> + *   state->polarity isn't honored.
>> + * - Instead of sleeping to wait for a completed period, the interrup=
t
>> + *   functionality could be used.
>=20
> This is definitively not trivial to do right. The main reason it is not=

> done so is that reading PWM_ISR will clear all the bits so it is
> necessary to be very careful to avoid race conditions. I'm not sure it
> is worth the effort.

I didn't intend to claim it is easy or even that it should be
implemented. This was just what I noticed while reading through driver
and manual. I thought it was a good idea to document that in case
someone finds time and motivation to work on this driver.

The first issue pointed out should however be easy to fix and IMHO is a
real bug. (Though it's a corner case that hardly ever triggers.)

Best regards
Uwe


--3UC7z54i9bPgQE5FgMPA5CLo4ZpV8QPUw--

--OpzLNV15XLyGK7w6j36LK6zLUuPvZ42iR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl1aWYkACgkQwfwUeK3K
7AlurAf/a9MA8BEhjxTtNdjaiBDLgxuDM125yu6jAG+S73XOyxuuKe63dP/VmLq1
GQZ0+IEz5kdH2/j2U8AK4cAFCSpIh+jzplPGXgeYvU0H2XMwqRH/Qz5r4ODB/p2u
AvxnMFT76BoMoC55WaZWwgSYeurlND9MRTUrqmDQgY6MumNFjhw38lA8y82rIGoU
+wZfQJkobSTvkb3UxwOuF5y2hcO2CSePEwIIWyqA9wXwYGFY25Mq19tC2ZlPbQ9q
5w0QSGl3CsbATmlEF/DW0HrmtUOXQ5rxcAm5Sg1YOjgeeXB9zzo2Zr4z6Wy0R9OV
vqL0Ang1RALihm9Mb+ImbI1DWQuxQg==
=nAxw
-----END PGP SIGNATURE-----

--OpzLNV15XLyGK7w6j36LK6zLUuPvZ42iR--


--===============4185649363601058837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4185649363601058837==--
