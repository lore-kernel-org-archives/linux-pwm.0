From: Brain WrecK <bloften80@gmail.com>
Subject: Re: [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
	control
Date: Mon, 29 Jun 2015 22:37:17 -0600
Message-ID: <CAA1t8St+Qr-3iCR-QydSXJwFQ_3-hbnt500BXfbnACefBnnVDg@mail.gmail.com>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <20150626163137.GB30960@phenom.ffwll.local>
 <20150626174756.GC5176@intel.com>
 <20150628221836.GH4633@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0508439363=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20150628221836.GH4633@windriver.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, varkabhadram@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Povilas Staniulis <wdmonster@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

--===============0508439363==
Content-Type: multipart/alternative; boundary=001a11c2c4cae301720519b4c21a

--001a11c2c4cae301720519b4c21a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tested by Brian Loften, "Brain Wreck" bloften80@gmail.com confirmed working
on ASUS T100TA, kernel 20150629 -next running 15.04 i386 Ubuntu Gnome --
suspend resume is functioning normally, backlight controls work before and
after resume using slide controls and meta keys on keyboard

On Sun, Jun 28, 2015 at 4:18 PM, Paul Gortmaker <
paul.gortmaker@windriver.com> wrote:

> [Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
> control] On 26/06/2015 (Fri 20:47) Ville Syrj=C3=A4l=C3=A4 wrote:
>
> > On Fri, Jun 26, 2015 at 06:31:37PM +0200, Daniel Vetter wrote:
> > > On Fri, Jun 26, 2015 at 02:32:03PM +0530, Shobhit Kumar wrote:
> > > > Hi,
> > > > Next update of the series reviewed at
> > > > https://lkml.org/lkml/2015/6/22/155
> > > >
> > > > Major changes are few review comments from Varka and Ville being
> addressed. Also except
> > > > for intel-gfx patches, all patches reviesion history is moved out o=
f
> commit message.
> > > >
> > > > Hope this series finally finds its mark.
> > > >
> > > > Regards
> > > > Shobhit
> > > >
> > > > Shobhit Kumar (7):
> > > >   gpiolib: Add support for removing registered consumer lookup tabl=
e
> > > >   mfd: intel_soc_pmic_core: Add lookup table for Panel Control as
> GPIO
> > > >     signal
> > > >   mfd: intel_soc_pmic_crc: Add PWM cell device for Crystalcove PMIC
> > > >   mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC based
> PWM
> > > >   pwm: crc: Add Crystalcove (CRC) PWM driver
> > > >   drm/i915: Use the CRC gpio for panel enable/disable
> > > >   drm/i915: Backlight control using CRC PMIC based PWM driver
> > >
> > > I think we have r-b/acks on all the patches now. Ok if I pull this in
> > > through drm-intel.git for 4.3? Or should I make a topic branch with t=
ag
> > > and then send out pull requests to everyone? Or will each maintainer
> merge
> > > on their own since it's all only coupled at runtime anyway? Any of
> these
> > > would suit me.
> >
> > I forgot to mention that I had a build failure due to
> > builtin_platform_driver() when I tried this (just changed it to
> > module_platform_driver() to get past it). So I'm not sure if this
> > now depends on some tree which isn't included in -nightly...
>
> builtin_platform_register does not yet exist in mainline; as Paul (the
> other one) said earlier.  So you can either open-code what it does for
> now, or use  module_platform_register.  If you do the latter, then
> ensure you (temorarily) also include module.h or you risk additional
> breakage in the future.
>
> Paul.
> --
>
> >
> > --
> > Ville Syrj=C3=A4l=C3=A4
> > Intel OTC
>

--001a11c2c4cae301720519b4c21a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8000001907349px">Tested by Bri=
an Loften, &quot;Brain Wreck&quot;=C2=A0</span><a href=3D"mailto:bloften80@=
gmail.com" target=3D"_blank" style=3D"font-size:12.8000001907349px">bloften=
80@gmail.com</a><span style=3D"font-size:12.8000001907349px">=C2=A0confirme=
d working on ASUS T100TA, kernel 20150629 -next running 15.04 i386 Ubuntu G=
nome -- suspend resume is functioning normally, backlight controls work bef=
ore and after resume using slide controls and meta keys on keyboard</span><=
br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, =
Jun 28, 2015 at 4:18 PM, Paul Gortmaker <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:paul.gortmaker@windriver.com" target=3D"_blank">paul.gortmaker@windriv=
er.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=
=3D"HOEnZb"><div class=3D"h5">[Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) P=
MIC based panel and pwm control] On 26/06/2015 (Fri 20:47) Ville Syrj=C3=A4=
l=C3=A4 wrote:<br>
<br>
&gt; On Fri, Jun 26, 2015 at 06:31:37PM +0200, Daniel Vetter wrote:<br>
&gt; &gt; On Fri, Jun 26, 2015 at 02:32:03PM +0530, Shobhit Kumar wrote:<br=
>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; Next update of the series reviewed at<br>
&gt; &gt; &gt; <a href=3D"https://lkml.org/lkml/2015/6/22/155" rel=3D"noref=
errer" target=3D"_blank">https://lkml.org/lkml/2015/6/22/155</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Major changes are few review comments from Varka and Ville b=
eing addressed. Also except<br>
&gt; &gt; &gt; for intel-gfx patches, all patches reviesion history is move=
d out of commit message.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hope this series finally finds its mark.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards<br>
&gt; &gt; &gt; Shobhit<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Shobhit Kumar (7):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0gpiolib: Add support for removing registered con=
sumer lookup table<br>
&gt; &gt; &gt;=C2=A0 =C2=A0mfd: intel_soc_pmic_core: Add lookup table for P=
anel Control as GPIO<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0signal<br>
&gt; &gt; &gt;=C2=A0 =C2=A0mfd: intel_soc_pmic_crc: Add PWM cell device for=
 Crystalcove PMIC<br>
&gt; &gt; &gt;=C2=A0 =C2=A0mfd: intel_soc_pmic_core: ADD PWM lookup table f=
or CRC PMIC based PWM<br>
&gt; &gt; &gt;=C2=A0 =C2=A0pwm: crc: Add Crystalcove (CRC) PWM driver<br>
&gt; &gt; &gt;=C2=A0 =C2=A0drm/i915: Use the CRC gpio for panel enable/disa=
ble<br>
&gt; &gt; &gt;=C2=A0 =C2=A0drm/i915: Backlight control using CRC PMIC based=
 PWM driver<br>
&gt; &gt;<br>
&gt; &gt; I think we have r-b/acks on all the patches now. Ok if I pull thi=
s in<br>
&gt; &gt; through drm-intel.git for 4.3? Or should I make a topic branch wi=
th tag<br>
&gt; &gt; and then send out pull requests to everyone? Or will each maintai=
ner merge<br>
&gt; &gt; on their own since it&#39;s all only coupled at runtime anyway? A=
ny of these<br>
&gt; &gt; would suit me.<br>
&gt;<br>
&gt; I forgot to mention that I had a build failure due to<br>
&gt; builtin_platform_driver() when I tried this (just changed it to<br>
&gt; module_platform_driver() to get past it). So I&#39;m not sure if this<=
br>
&gt; now depends on some tree which isn&#39;t included in -nightly...<br>
<br>
</div></div>builtin_platform_register does not yet exist in mainline; as Pa=
ul (the<br>
other one) said earlier.=C2=A0 So you can either open-code what it does for=
<br>
now, or use=C2=A0 module_platform_register.=C2=A0 If you do the latter, the=
n<br>
ensure you (temorarily) also include module.h or you risk additional<br>
breakage in the future.<br>
<br>
Paul.<br>
--<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; --<br>
&gt; Ville Syrj=C3=A4l=C3=A4<br>
&gt; Intel OTC<br>
</div></div></blockquote></div><br></div>

--001a11c2c4cae301720519b4c21a--

--===============0508439363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK

--===============0508439363==--
