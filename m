From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC] pwm: chip_data vs device_data
Date: Tue, 6 Oct 2015 11:14:34 +0200
Message-ID: <20151006091434.GC22087@ulmo.nvidia.com>
References: <56137655.40804@schinagl.nl>
 <20151006073856.GB18633@ulmo>
 <5613848E.2060800@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34187 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbJFJOg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 05:14:36 -0400
Content-Disposition: inline
In-Reply-To: <5613848E.2060800@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver+list@schinagl.nl>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olliver Schinagl <oliver@schinagl.nl>


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2015 at 10:21:34AM +0200, Olliver Schinagl wrote:
> Hey Thierry,
>=20
> thans for your quick reply :)
>=20
> On 06-10-15 09:38, Thierry Reding wrote:
> >On Tue, Oct 06, 2015 at 09:20:53AM +0200, Olliver Schinagl wrote:
> >>Hey Thierry, list,
> >>
> >>While working on something in the pwm framework, I noticed that the void
> >>*data in the pwm_device struct is called chip_data. Why is it not called
> >>device_data, since it is the data associated with a PWM device, rather =
then
> >>the chip, and on that note, if it really is chip related data (thus cov=
ering
> >>the whole chip, not just the single pwm device) why is there no chip_da=
ta in
> >>pwm_chip?
> >The reason for the name is that it's chip-specific data associated with
> >a struct pwm_device. That is, a PWM chip implementation (i.e. driver)
> >can use it to keep per-PWM data that's not in struct pwm_device itself.
> Then I have to wrap my head around what is a chip and what is a device :)
>=20
> To me, it seems that a chip can hold X number of pwm devices, and each
> pwm_device has a unique set of properties, duty, plarity, period. So it
> seems that some device specific data could go here as well, where i'm bad=
 at
> examples now

I think we're really talking about the same thing here. This is used for
device-specific data. The chip_ prefix merely means that the chip driver
"owns" the data.

> >>Again, is this something worth my time to add a device_data and rename
> >>chip_data?
> >device_data would be redundant because it's already part of struct
> >pwm_device. Plain data might be okay, but I like the chip_ prefix
> >because it marks the data as being chip-specific data rather than
> >generic.
> well here i'd imagine the chip specific data (not allready in the struct).

Data specific to a chip is what you're supposed to embed in your driver-
specific data structure (which embeds struct pwm_chip). Like you said it
is data that pertains to the whole chip, so doesn't need to be per-PWM.

Thierry

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWE5D6AAoJEN0jrNd/PrOhj7gQAITodvTzVtds4bbysrjmByrN
0EcFIqJXa9pbvlsQuC7XseCXOLzOI85LvkuZBMRYpgT8ozhLSXFPjObzzp/gw5M2
lhr/+5HndpR05W3lZJVeL8JVxXpP11eH5kSZd2GptAKdvkYwGQ9UWrJjvhF2bMw5
5Tk/XpRLmSAuXdWlaPUHIbUZYNNxgNFlPprv1RuPqpruDujN8LRmMlt7pezCrv/s
TpkAh2sIeFeecBgL5fUbanQxVcuXQNqxWTSH4DVlzO1cnxeJVq2jPcNiu7Tcx4Gx
/wlr4AuUMOX/C6mR1ND5iR2aA/lR4kOw11KOvWvH7UHIRPxfiKv0Jh5XPcXYJII1
OPPrGPDcSYSelxAKn5g+augCnU/A8fajOC5uk4mFfUBxjvogrwoZXzyc9HEjfpYh
R0HOPJVbFroLAeNWLkBX4I57ft5Y6kCQK5WOPXOh+WNLnVIdCuF8hxJm9XmVVUjC
zst10OI6UdAlNXJF9lBNrYJ8UUOQ094Ow5vMRZE24Lrq1w0ypUw+jZkFyaMysmHL
n94MVWPd8y0hesI3u1gONoGqb5OCf03vKZ1bpiRieHSaHPCXx17FT7A33/qthXG9
pu8tFpqbTBWRd6KeZzZcGi1kncT8CnLmwPfPtfCCYX+DR1YGqJ8Ka+lxe8F4CKgV
tAWGs7XsshwniV0blNSK
=1u0k
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
