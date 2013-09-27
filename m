Return-Path: <tomi.valkeinen@ti.com>
Message-ID: <52452BF7.2070606@ti.com>
Date: Fri, 27 Sep 2013 09:55:51 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm-backlight: add support for device tree gpio control
References: <1378236372-15711-1-git-send-email-mikedunn@newsguy.com> <20130910172130.GC22111@ulmo> <523056A6.5060000@newsguy.com> <524408BE.40402@ti.com> <20130926120248.GB1680@ulmo> <524427E5.50403@ti.com> <20130926125020.GA2141@ulmo>
In-Reply-To: <20130926125020.GA2141@ulmo>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HxjO6blm5es6nkSTsNxb16vg49M9Ni0vs"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mike Dunn <mikedunn@newsguy.com>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>

--HxjO6blm5es6nkSTsNxb16vg49M9Ni0vs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/09/13 15:50, Thierry Reding wrote:

>> I thought the NAK was for the DT parts, not for the sequences as such.=
 I
>> don't remember anyone shooting down the idea of defining power sequenc=
es
>> inside a driver.
>=20
> Yes, but the DT parts were the primary reason why they were written in
> the first place. Without DT we can just use the existing hooks to do th=
e
> sequencing. There is not much to be gained from power sequences.

Board hooks? Those cannot be used with DT boot.

But yes, the power sequences without DT (or platform data) parts cannot
handle with board-specific-things. I still think it'd be a very nice
thing to have inside the drivers. A single driver could more easily
handle bunch of somewhat similar devices, by specifying power sequences
in a table, one sequence for each device.

> There is unfortunately always the next crazy setup that one can think
> of. I personally prefer to support what we have (or at least the
> majority of that) with something generic and tackle the more exotic
> setups later on (or when they appear, as the case may be).
>=20
> As things stand right now, there's no way to get the simplest panel
> setup to work properly if you use DT. By adding both an enable GPIO and=

> a power supply regulator we can at least cover the sane use-cases with
> some sane and pretty simple code.

Sure, no disagreement there.

 Tomi



--HxjO6blm5es6nkSTsNxb16vg49M9Ni0vs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRSv3AAoJEPo9qoy8lh719hMP/1RUUsASGlVzN2sJv6alLJ9P
aECdmSwcsB5n/+Eb0W+d9T8yDVypV2slJQrwO2tFJ4YmTwqfqlzVNN1QwiNQ4jjB
mi8D+Eym3e1yI7LlrEX5BvmwUmttgLqxQ/yPVVl4EWLymtXriVqXc7/NQBNdUMG4
mFGqO+Nd5LORFiTZLY31Oe9UEL/WIOr+Tq/7sX/Uh4vi9h6O/2RoolBgqn2hMCI7
IMT8/EyRHri/vfu8+OFohQHqyBAEfs/0W8+JcdAmjwg4z9gINjNoeWNBQExO+hAE
hICcUb54LjAk854mxm2CXBLwfHfrU4MRY5FC9Uo1VIGncY0VQoTkjQAO8rTXTQSB
AHZRbhHQGhfrO7eODYDQmSX/T85lD1jK3Wuzb0CbcWNw+YrV76aEA3HuFMXStKjf
X3kNAPi6c52RGfh8TbVTxf3h6taIWr71RNtx0niiFgaK4XEcAaJ23gvUjVvLY2ug
4g05sHsvl8GuKFeYUASHVwrM7bZytryRWRc83RByAMk/IWiLeI5AiW4WdWKauPiw
eOWfRs+wMReu+xjhoZAYLUZuNRO13Bz+e7wFxkki4NEC9Mm5PeshLH8vL5CezFvt
uRSsPqqpngYw+gBlb0XKX9AOPP6ZM04csNzvZpT9SE+8MJvmwFBRuSxRVaR7l8s8
zV5dI3+jVeRXLmqummzy
=C/XC
-----END PGP SIGNATURE-----

--HxjO6blm5es6nkSTsNxb16vg49M9Ni0vs--
