From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
 control
Date: Tue, 21 Jul 2015 09:24:01 +0200
Message-ID: <20150721072401.GR16722@phenom.ffwll.local>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <20150626163137.GB30960@phenom.ffwll.local>
 <20150626174756.GC5176@intel.com>
 <20150628221836.GH4633@windriver.com>
 <CAAbrOmcOt_XKJP+2+=vmezSXLTU0woavsNDreU7haK-ADoE4JQ@mail.gmail.com>
 <CAAbrOmd5woeZ3jcWq-Xz7f1H5go-RujaUqO=2VSfth5MO60tRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAbrOmd5woeZ3jcWq-Xz7f1H5go-RujaUqO=2VSfth5MO60tRA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <kumar@shobhit.info>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Daniel Vetter <daniel.vetter@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Varka Bhadram <varkabhadram@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Brain WrecK <bloften80@gmail.com>, Povilas Staniulis <wdmonster@gmail.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jul 21, 2015 at 12:43:48PM +0530, Shobhit Kumar wrote:
> On Fri, Jul 10, 2015 at 6:36 PM, Shobhit Kumar <kumar@shobhit.info> w=
rote:
> > On Mon, Jun 29, 2015 at 3:48 AM, Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> >> [Re: [Intel-gfx] [v3 0/7] Crystalcove (CRC) PMIC based panel and p=
wm control] On 26/06/2015 (Fri 20:47) Ville Syrj=E4l=E4 wrote:
> >>
> >>> On Fri, Jun 26, 2015 at 06:31:37PM +0200, Daniel Vetter wrote:
> >>> > On Fri, Jun 26, 2015 at 02:32:03PM +0530, Shobhit Kumar wrote:
> >>> > > Hi,
> >>> > > Next update of the series reviewed at
> >>> > > https://lkml.org/lkml/2015/6/22/155
> >>> > >
> >>> > > Major changes are few review comments from Varka and Ville be=
ing addressed. Also except
> >>> > > for intel-gfx patches, all patches reviesion history is moved=
 out of commit message.
> >>> > >
> >>> > > Hope this series finally finds its mark.
> >>> > >
> >>> > > Regards
> >>> > > Shobhit
> >>> > >
> >>> > > Shobhit Kumar (7):
> >>> > >   gpiolib: Add support for removing registered consumer looku=
p table
> >>> > >   mfd: intel_soc_pmic_core: Add lookup table for Panel Contro=
l as GPIO
> >>> > >     signal
> >>> > >   mfd: intel_soc_pmic_crc: Add PWM cell device for Crystalcov=
e PMIC
> >>> > >   mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC=
 based PWM
> >>> > >   pwm: crc: Add Crystalcove (CRC) PWM driver
> >>> > >   drm/i915: Use the CRC gpio for panel enable/disable
> >>> > >   drm/i915: Backlight control using CRC PMIC based PWM driver
> >>> >
> >>> > I think we have r-b/acks on all the patches now. Ok if I pull t=
his in
> >>> > through drm-intel.git for 4.3? Or should I make a topic branch =
with tag
> >>> > and then send out pull requests to everyone? Or will each maint=
ainer merge
> >>> > on their own since it's all only coupled at runtime anyway? Any=
 of these
> >>> > would suit me.
> >>>
> >>> I forgot to mention that I had a build failure due to
> >>> builtin_platform_driver() when I tried this (just changed it to
> >>> module_platform_driver() to get past it). So I'm not sure if this
> >>> now depends on some tree which isn't included in -nightly...
> >>
> >> builtin_platform_register does not yet exist in mainline; as Paul =
(the
> >> other one) said earlier.  So you can either open-code what it does=
 for
> >> now, or use  module_platform_register.  If you do the latter, then
> >> ensure you (temorarily) also include module.h or you risk addition=
al
> >> breakage in the future.
> >>
> >
> > Guess its in mainline now. Whats the plan for the merge of these pa=
tches ?
> >
>=20
> Do I need to do anything further on these patches ? Daniel can you
> help in the next steps.

I'm pulling them into a topic branch and then get it merged through
drm-intel.git. If other maintainers want to I can send them a pull requ=
est
for that topic branch too.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
