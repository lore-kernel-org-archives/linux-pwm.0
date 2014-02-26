From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Wed, 26 Feb 2014 16:00:46 +0000
Message-ID: <20140226160046.GD29659@e106331-lin.cambridge.arm.com>
References: <1393342067-9086-1-git-send-email-shc_work@mail.ru>
 <5560556.tENBsUTXbt@wuerfel>
 <1393343277.220396804@f361.i.mail.ru>
 <5211076.9eDkSrDagS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62666 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751683AbaBZQBC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 11:01:02 -0500
Content-Disposition: inline
In-Reply-To: <5211076.9eDkSrDagS@wuerfel>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Shiyan <shc_work@mail.ru>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Tue, Feb 25, 2014 at 03:50:32PM +0000, Arnd Bergmann wrote:
> On Tuesday 25 February 2014 19:47:57 Alexander Shiyan wrote:
> > =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 25 =D1=84=D0=B5=D0=B2=D1=
=80=D0=B0=D0=BB=D1=8F 2014, 16:33 +01:00 =D0=BE=D1=82 Arnd Bergmann <ar=
nd@arndb.de>:
> > > On Tuesday 25 February 2014 19:27:47 Alexander Shiyan wrote:
> =3D> >=20
> > > We really want to avoid wildcards in compatible strings. Can you =
call this
> > > "cirrus,cs89712-pwm" to match the first SoC that came with this h=
ardware?
> > > Obviously if there was some chip before that (I'm not familiar wi=
th the
> > > model numbers), use that instead.
> > >=20
> > > You can either list all chips you know that have this in the driv=
er,
> > > or you use "cirrus,cs89712-pwm" as the fallback, and use the name=
 of
> > > the SoC you have as the more specific string.
> >=20
> > It seems that in this case we will need to modify the compatibility=
 string
> > for other drivers that are already available in the kernel...
>=20
> Ah, right. I missed the binding for gpio and serial going in.
>=20
> DT maintainers, any suggestion on how we should proceed here?
>=20
> AFAICT, clps711x platform support is still work-in-progress, so we do=
n't
> have any upstream users to worry about yet, but changing them is stil=
l
> going to be slightly messy.

When allocating any new compatible strings, as Arnd says, we should
avoid wildcards as they're usually far too encompassing and end up
causing more trouble than they're worth.

In this case how problematic are the wildcard strings?

I assume we still have specific strings earlier in any compatible list
in any case? If not, and there are possible differences, that should be
fixed right away.

We have a few options:

a) Update the docs only.

   Note in the docs that "cirrus,clps711x-$UNIT" means anything
   compatible with the $UNIT in the cs89712. This may be
   counter-intuitive, and if a new clps711x platform comes out with an
   incompatible $UNIT it should omit "cirrus,clps711x-$UNIT" from its
   compatible list, but otherwise no harm done.

b) Deprecate the existing string.
 =20
   Add "cirrus,cs89712-$UNIT" to the binding docs and driver. Mark
   "cirrus,clps711x-$UNIT" as deprecated in the binding document.
   Replace "cirrus,clps711x-$UNIT" with "cirrus,cs89712-$UNIT" in all
   DTs.

   This will mean new DTBs won't work with an older kernel, but as
   support is a work in progress that might not matter. Old DTBs will
   continue to function.

   Iff you can guarantee that the old string is not possibly being used
   by anyone, it can be dropped from the driver. If not it has to remai=
n
   (though can be commented to be deprecated), so that old DTBs
   function. It's probably best to leave it there.
 =20
c) Deprecate, maintaining (forwards) compatibility.

   As above, but rather than replacing "cirrus,clps711x-$UNIT" with
   "cirrus,cs89712-$UNIT" in DTs, place "cirrus,cs89712-$UNIT" before
   "cirrus,clps711x-$UNIT" in DTs. This allows new DTBs to work with
   older kernels too. Depending on what level of support you have in
   mainline currently this may or may not be an important consideration=
=2E

Cheers,
Mark.
