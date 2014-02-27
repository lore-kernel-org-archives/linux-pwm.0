From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Thu, 27 Feb 2014 10:27:09 +0000
Message-ID: <20140227102709.GD6945@e106331-lin.cambridge.arm.com>
References: <1393342067-9086-1-git-send-email-shc_work@mail.ru>
 <5211076.9eDkSrDagS@wuerfel>
 <20140226160046.GD29659@e106331-lin.cambridge.arm.com>
 <1393433446.816907298@f337.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50151 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200AbaB0K12 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2014 05:27:28 -0500
Content-Disposition: inline
In-Reply-To: <1393433446.816907298@f337.i.mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Wed, Feb 26, 2014 at 04:50:46PM +0000, Alexander Shiyan wrote:
> Hello.
>=20
> =D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 26 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=
=D1=8F 2014, 16:00 UTC =D0=BE=D1=82 Mark Rutland <mark.rutland@arm.com>=
:
> > On Tue, Feb 25, 2014 at 03:50:32PM +0000, Arnd Bergmann wrote:
> > > On Tuesday 25 February 2014 19:47:57 Alexander Shiyan wrote:
> > > > =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 25 =D1=84=D0=B5=D0=B2=
=D1=80=D0=B0=D0=BB=D1=8F 2014, 16:33 +01:00 =D0=BE=D1=82 Arnd Bergmann =
<arnd@arndb.de>:
> > > > > On Tuesday 25 February 2014 19:27:47 Alexander Shiyan wrote:
> > > =3D> >=20
> > > > > We really want to avoid wildcards in compatible strings. Can =
you call this
> > > > > "cirrus,cs89712-pwm" to match the first SoC that came with th=
is hardware?
> > > > > Obviously if there was some chip before that (I'm not familia=
r with the
> > > > > model numbers), use that instead.
> > > > >=20
> > > > > You can either list all chips you know that have this in the =
driver,
> > > > > or you use "cirrus,cs89712-pwm" as the fallback, and use the =
name of
> > > > > the SoC you have as the more specific string.
> > > >=20
> > > > It seems that in this case we will need to modify the compatibi=
lity string
> > > > for other drivers that are already available in the kernel...
> > >=20
> > > Ah, right. I missed the binding for gpio and serial going in.
> > >=20
> > > DT maintainers, any suggestion on how we should proceed here?
> > >=20
> > > AFAICT, clps711x platform support is still work-in-progress, so w=
e don't
> > > have any upstream users to worry about yet, but changing them is =
still
> > > going to be slightly messy.
> >=20
> > When allocating any new compatible strings, as Arnd says, we should
> > avoid wildcards as they're usually far too encompassing and end up
> > causing more trouble than they're worth.
> >=20
> > In this case how problematic are the wildcard strings?
> >=20
> > I assume we still have specific strings earlier in any compatible l=
ist
> > in any case? If not, and there are possible differences, that shoul=
d be
> > fixed right away.
> >=20
> > We have a few options:
> >=20
> > a) Update the docs only.
> >=20
> >    Note in the docs that "cirrus,clps711x-$UNIT" means anything
> >    compatible with the $UNIT in the cs89712. This may be
> >    counter-intuitive, and if a new clps711x platform comes out with=
 an
> >    incompatible $UNIT it should omit "cirrus,clps711x-$UNIT" from i=
ts
> >    compatible list, but otherwise no harm done.
> >=20
> > b) Deprecate the existing string.
> >  =20
> >    Add "cirrus,cs89712-$UNIT" to the binding docs and driver. Mark
> >    "cirrus,clps711x-$UNIT" as deprecated in the binding document.
> >    Replace "cirrus,clps711x-$UNIT" with "cirrus,cs89712-$UNIT" in a=
ll
> >    DTs.
> >=20
> >    This will mean new DTBs won't work with an older kernel, but as
> >    support is a work in progress that might not matter. Old DTBs wi=
ll
> >    continue to function.
> >=20
> >    Iff you can guarantee that the old string is not possibly being =
used
> >    by anyone, it can be dropped from the driver. If not it has to r=
emain
> >    (though can be commented to be deprecated), so that old DTBs
> >    function. It's probably best to leave it there.
> >  =20
> > c) Deprecate, maintaining (forwards) compatibility.
> >=20
> >    As above, but rather than replacing "cirrus,clps711x-$UNIT" with
> >    "cirrus,cs89712-$UNIT" in DTs, place "cirrus,cs89712-$UNIT" befo=
re
> >    "cirrus,clps711x-$UNIT" in DTs. This allows new DTBs to work wit=
h
> >    older kernels too. Depending on what level of support you have i=
n
> >    mainline currently this may or may not be an important considera=
tion.
>=20
> If I understood correctly, in the variant "a", we change nothing.
> Ie compatibility string is a global to entire platform, and in case o=
f any
> CPU differences, we simply add the additional compatibility string fu=
lly
> meets the CPU name, for example for Cirrus Logic EP7312 this will be
> like: "cirrus,ep7312-hw", "cirrus,clps711x-hw".
> Correct?

That depends. Option a still requires that we give a definite meaning t=
o
"cirrus,clps711x-$UNIT" to mean compatible with the unit on the cs89712=
=2E

If a new unit is compatible with this, then it can have
"cirrus,clps711x-$UNIT" as a fallback in its compatible list.

If a new unit is not compatible and must be handled differently, then i=
t
should not have "cirrus,clps711x-$UNIT" in its compatible list.

The naming you suggest for "cirrus,ep7312-$UNIT" seems sensible in
either case.

Cheers,
Mark.
