Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <YFhhGpiHDELxIo9V@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet> <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet> <YFhhGpiHDELxIo9V@orome.fritz.box>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Mar 2021 11:38:40 +0200
Message-ID: <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000be186205be1cd4ac"
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, Sven Van Asbroeck <thesven73@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-ID: <linux-pwm.vger.kernel.org>

--000000000000be186205be1cd4ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, March 22, 2021, Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> > Hi Sven,
> >
> > On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:
> > > Hi Clemens,
> > >
> > > On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
> > > <clemens.gruber@pqgruber.com> wrote:
> > > >
> > > > Ok, so you suggest we extend our get_state logic to deal with cases
> > > > like the following:
> > >
> > > Kind of. We can't control how other actors (bootloaders etc) program
> the
> > > chip. As far as I know, there are many, many different register
> settings that
> > > result in the same physical chip outputs. So if .probe() wants to
> preserve the
> > > existing chip settings, .get_state() has to be able to deal with ever=
y
> possible
> > > setting. Even invalid ones.
> >
> > Is the driver really responsible for bootloaders that program the chip
> > with invalid values?
> > The chip comes out of PoR with sane default values. If the bootloader o=
f
> > a user messes them up, isn't that a bootloader problem instead of a
> > Linux kernel driver problem?
>
> It is ultimately a problem of the bootloader and where possible the
> bootloader should be fixed. However, fixing bootloaders sometimes isn't
> possible, or impractical, so the kernel has to be able to deal with
> hardware that's been badly programmed by the bootloader. Within reason,
> of course. Sometimes this can't be done in any other way than forcing a
> hard reset of the chip, but it should always be a last resort.
>
> > > In addition, .apply() cannot make any assumptions as to which bits ar=
e
> > > already set/cleared on the chip. Including preserved, invalid setting=
s.
> > >
> > > This might get quite complex.
> > >
> > > However if we reset the chip in .probe() to a known state (a
> normalized state,
> > > in the mathematical sense), then both .get_state() and .apply() becom=
e
> > > much simpler. because they only need to deal with known, normalized
> states.
> >
> > Yes, I agree. This would however make it impossible to do a flicker-fre=
e
> > transition from bootloader to kernel, but that's not really a usecase I
> > have so I can live without it.
> >
> > Another point in favor of resetting is that the driver already does it.
> > Removing the reset of the OFF register may break some boards who rely o=
n
> > that behaviour.
> > My version only extended the reset to include the ON register.
> >
> > >
> > > In short, it's a tradeoff between code complexity, and user
> friendliness/
> > > features.
> > >
> > > Sven
> >
> > Thierry, Uwe, what's your take on this?
> >
> > Thierry: Would you accept it if we continue to reset the registers in
> > .probe?
>
> Yes, I think it's fine to continue to reset the registers since that's
> basically what the driver already does. It'd be great if you could
> follow up with a patch that removes the reset and leaves the hardware in
> whatever state the bootloader has set up. Then we can take that patch
> for a ride and see if there are any complains about it breaking. If
> there are we can always try to fix them, but as a last resort we can
> also revert, which then may be something we have to live with. But I
> think we should at least try to make this consistent with how other
> drivers do this so that people don't stumble over this particular
> driver's


I guess we may miss (a PCB / silicon design flaw or warm boot case) when
boot loader left device completely untouched and device either in wrong
state because if failed reset (saw this on PCA9555 which has a
corresponding errata), or simply we have done a warm reset of the system.
So, we also have to understand how to properly exit.

Another point, CCF has a bit =E2=80=9Cis critical=E2=80=9D, and u guess PWM=
 may get the
same and make the all assumptions much easier.


>
> Thierry
>


--=20
With Best Regards,
Andy Shevchenko

--000000000000be186205be1cd4ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, March 22, 2021, Thierry Reding &lt;<a href=3D"mailto:thi=
erry.reding@gmail.com">thierry.reding@gmail.com</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gru=
ber wrote:<br>
&gt; Hi Sven,<br>
&gt; <br>
&gt; On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:<br>
&gt; &gt; Hi Clemens,<br>
&gt; &gt; <br>
&gt; &gt; On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber<br>
&gt; &gt; &lt;<a href=3D"mailto:clemens.gruber@pqgruber.com">clemens.gruber=
@pqgruber.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Ok, so you suggest we extend our get_state logic to deal wit=
h cases<br>
&gt; &gt; &gt; like the following:<br>
&gt; &gt; <br>
&gt; &gt; Kind of. We can&#39;t control how other actors (bootloaders etc) =
program the<br>
&gt; &gt; chip. As far as I know, there are many, many different register s=
ettings that<br>
&gt; &gt; result in the same physical chip outputs. So if .probe() wants to=
 preserve the<br>
&gt; &gt; existing chip settings, .get_state() has to be able to deal with =
every possible<br>
&gt; &gt; setting. Even invalid ones.<br>
&gt; <br>
&gt; Is the driver really responsible for bootloaders that program the chip=
<br>
&gt; with invalid values?<br>
&gt; The chip comes out of PoR with sane default values. If the bootloader =
of<br>
&gt; a user messes them up, isn&#39;t that a bootloader problem instead of =
a<br>
&gt; Linux kernel driver problem?<br>
<br>
It is ultimately a problem of the bootloader and where possible the<br>
bootloader should be fixed. However, fixing bootloaders sometimes isn&#39;t=
<br>
possible, or impractical, so the kernel has to be able to deal with<br>
hardware that&#39;s been badly programmed by the bootloader. Within reason,=
<br>
of course. Sometimes this can&#39;t be done in any other way than forcing a=
<br>
hard reset of the chip, but it should always be a last resort.<br>
<br>
&gt; &gt; In addition, .apply() cannot make any assumptions as to which bit=
s are<br>
&gt; &gt; already set/cleared on the chip. Including preserved, invalid set=
tings.<br>
&gt; &gt; <br>
&gt; &gt; This might get quite complex.<br>
&gt; &gt; <br>
&gt; &gt; However if we reset the chip in .probe() to a known state (a norm=
alized state,<br>
&gt; &gt; in the mathematical sense), then both .get_state() and .apply() b=
ecome<br>
&gt; &gt; much simpler. because they only need to deal with known, normaliz=
ed states.<br>
&gt; <br>
&gt; Yes, I agree. This would however make it impossible to do a flicker-fr=
ee<br>
&gt; transition from bootloader to kernel, but that&#39;s not really a usec=
ase I<br>
&gt; have so I can live without it.<br>
&gt; <br>
&gt; Another point in favor of resetting is that the driver already does it=
.<br>
&gt; Removing the reset of the OFF register may break some boards who rely =
on<br>
&gt; that behaviour.<br>
&gt; My version only extended the reset to include the ON register.<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; In short, it&#39;s a tradeoff between code complexity, and user f=
riendliness/<br>
&gt; &gt; features.<br>
&gt; &gt; <br>
&gt; &gt; Sven<br>
&gt; <br>
&gt; Thierry, Uwe, what&#39;s your take on this?<br>
&gt; <br>
&gt; Thierry: Would you accept it if we continue to reset the registers in<=
br>
&gt; .probe?<br>
<br>
Yes, I think it&#39;s fine to continue to reset the registers since that&#3=
9;s<br>
basically what the driver already does. It&#39;d be great if you could<br>
follow up with a patch that removes the reset and leaves the hardware in<br=
>
whatever state the bootloader has set up. Then we can take that patch<br>
for a ride and see if there are any complains about it breaking. If<br>
there are we can always try to fix them, but as a last resort we can<br>
also revert, which then may be something we have to live with. But I<br>
think we should at least try to make this consistent with how other<br>
drivers do this so that people don&#39;t stumble over this particular<br>
driver&#39;s=C2=A0</blockquote><div><br></div><div>I guess we may miss (a P=
CB / silicon design flaw or warm boot case) when boot loader left device co=
mpletely untouched and device either in wrong state because if failed reset=
 (saw this on PCA9555 which has a corresponding errata), or simply we have =
done a warm reset of the system. So, we also have to understand how to prop=
erly exit.</div><div><br></div><div>Another point, CCF has a bit =E2=80=9Ci=
s critical=E2=80=9D, and u guess PWM may get the same and make the all assu=
mptions much easier.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
Thierry<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--000000000000be186205be1cd4ac--
