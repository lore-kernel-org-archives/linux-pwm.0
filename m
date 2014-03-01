From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Sat, 1 Mar 2014 10:06:41 +0400
Message-ID: <20140301100641.cdb4398a4172700cfd318213@mail.ru>
References: <1393342067-9086-1-git-send-email-shc_work@mail.ru>
	<5560556.tENBsUTXbt@wuerfel>
	<1393343277.220396804@f361.i.mail.ru>
	<5211076.9eDkSrDagS@wuerfel>
	<20140226160046.GD29659@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.176.42]:53698 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaCAGHE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Mar 2014 01:07:04 -0500
In-Reply-To: <20140226160046.GD29659@e106331-lin.cambridge.arm.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Wed, 26 Feb 2014 16:00:46 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Feb 25, 2014 at 03:50:32PM +0000, Arnd Bergmann wrote:
> > On Tuesday 25 February 2014 19:47:57 Alexander Shiyan wrote:
> > > =F7=D4=CF=D2=CE=C9=CB, 25 =C6=C5=D7=D2=C1=CC=D1 2014, 16:33 +01:0=
0 =CF=D4 Arnd Bergmann <arnd@arndb.de>:
> > > > On Tuesday 25 February 2014 19:27:47 Alexander Shiyan wrote:
> > =3D> >=20
> > > > We really want to avoid wildcards in compatible strings. Can yo=
u call this
> > > > "cirrus,cs89712-pwm" to match the first SoC that came with this=
 hardware?
> > > > Obviously if there was some chip before that (I'm not familiar =
with the
> > > > model numbers), use that instead.
> > > >=20
> > > > You can either list all chips you know that have this in the dr=
iver,
> > > > or you use "cirrus,cs89712-pwm" as the fallback, and use the na=
me of
> > > > the SoC you have as the more specific string.
> > >=20
> > > It seems that in this case we will need to modify the compatibili=
ty string
> > > for other drivers that are already available in the kernel...
> >=20
> > Ah, right. I missed the binding for gpio and serial going in.
> >=20
> > DT maintainers, any suggestion on how we should proceed here?
> >=20
> > AFAICT, clps711x platform support is still work-in-progress, so we =
don't
> > have any upstream users to worry about yet, but changing them is st=
ill
> > going to be slightly messy.
>=20
> When allocating any new compatible strings, as Arnd says, we should
> avoid wildcards as they're usually far too encompassing and end up
> causing more trouble than they're worth.
>=20
> In this case how problematic are the wildcard strings?
>=20
> I assume we still have specific strings earlier in any compatible lis=
t
> in any case? If not, and there are possible differences, that should =
be
> fixed right away.
>=20
> We have a few options:
>=20
> a) Update the docs only.
>=20
>    Note in the docs that "cirrus,clps711x-$UNIT" means anything
>    compatible with the $UNIT in the cs89712. This may be
>    counter-intuitive, and if a new clps711x platform comes out with a=
n
>    incompatible $UNIT it should omit "cirrus,clps711x-$UNIT" from its
>    compatible list, but otherwise no harm done.
>=20
> b) Deprecate the existing string.
>  =20
>    Add "cirrus,cs89712-$UNIT" to the binding docs and driver. Mark
>    "cirrus,clps711x-$UNIT" as deprecated in the binding document.
>    Replace "cirrus,clps711x-$UNIT" with "cirrus,cs89712-$UNIT" in all
>    DTs.
>=20
>    This will mean new DTBs won't work with an older kernel, but as
>    support is a work in progress that might not matter. Old DTBs will
>    continue to function.
>=20
>    Iff you can guarantee that the old string is not possibly being us=
ed
>    by anyone, it can be dropped from the driver. If not it has to rem=
ain
>    (though can be commented to be deprecated), so that old DTBs
>    function. It's probably best to leave it there.
>  =20
> c) Deprecate, maintaining (forwards) compatibility.
>=20
>    As above, but rather than replacing "cirrus,clps711x-$UNIT" with
>    "cirrus,cs89712-$UNIT" in DTs, place "cirrus,cs89712-$UNIT" before
>    "cirrus,clps711x-$UNIT" in DTs. This allows new DTBs to work with
>    older kernels too. Depending on what level of support you have in
>    mainline currently this may or may not be an important considerati=
on.

Hello.

I want to elaborate on the current CLPS711X lineup:
PS7110  - EOL October 30, 2001
PS7111  - EOL October 30, 2001
EP7209  - EOL April 25, 2003
EP7211  - EOL April 25, 2003
EP7212  - EOL April 25, 2003
CS89712 - EOL August 15, 2005
EP7309  - Production
EP7311  - Production
EP7312  - Production

So at the moment, and long enough, produced only three models of CPUs.
I am sure that the hardware with old CPUs will not be able to use the
new kernel due to memory limitations, low CPU frequency, etc.

My suggestion is to always use a compatibility string for platform enti=
rely,
ie "cirrus,clps711x-$UNIT", otherwise it may result in misleading.

In any case, I would like to hear the final decision on this issue,
since there are several drivers already using this scheme and some driv=
ers
awaiting applying into the kernel.
I do not insist on its position, but just want to clarify to make chang=
es
to existing drivers and use the approved compatibility string in the fu=
ture.
At the current stage, these changes will not lead to anything terrible.

Thanks.
--=20
Alexander Shiyan <shc_work@mail.ru>
