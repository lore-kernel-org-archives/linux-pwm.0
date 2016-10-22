From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Sat, 22 Oct 2016 12:57:52 +0200
Message-ID: <20161022125752.61cfca30@bbrezillon>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
        <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
        <5325a332099473a2d8382530f79c5a8e@agner.ch>
        <20161013001540.7f759158@jawa>
        <ff9ba34df2729204c617685dd26ea625@agner.ch>
        <20161013065812.0da91859@jawa>
        <20161020103018.44fb94ea@jawa>
        <1b72dcbc9a021e6fa3aef62f63bbf93f@agner.ch>
        <20161021234939.1a4f51f4@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021234939.1a4f51f4@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

Hi Lukasz,

On Fri, 21 Oct 2016 23:49:39 +0200
Lukasz Majewski <l.majewski@majess.pl> wrote:

> Hi Stefan,
> 
> > On 2016-10-20 01:30, Lukasz Majewski wrote:  
> > > Hi Stefan,
> > >   
> > >> Hi Stefan,
> > >>  
> > >> > On 2016-10-12 15:15, Lukasz Majewski wrote:  
> > >> > > Hi Stefan,
> > >> > >  
> > >> > >> On 2016-10-07 08:11, Bhuvanchandra DV wrote:  
> > >> > >> > From: Lothar Wassmann <LW@KARO-electronics.de>
> > >> > >> >
> > >> > >> > The i.MX pwm unit on i.MX27 and newer SoCs provides a
> > >> > >> > configurable output polarity. This patch adds support to
> > >> > >> > utilize this feature where available.
> > >> > >> >
> > >> > >> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> > >> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > >> > >> > Signed-off-by: Bhuvanchandra DV
> > >> > >> > <bhuvanchandra.dv@toradex.com> Acked-by: Shawn Guo
> > >> > >> > <shawn.guo@linaro.org> Reviewed-by: Sascha Hauer
> > >> > >> > <s.hauer@pengutronix.de> ---
> > >> > >> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
> > >> > >> >  drivers/pwm/pwm-imx.c                             | 51
> > >> > >> > +++++++++++++++++++++-- 2 files changed, 51 insertions(+), 6
> > >> > >> > deletions(-)
> > >> > >> >
> > >> > >> > diff --git
> > >> > >> > a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > >> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
> > >> > >> > e00c2e9..c61bdf8 100644 ---
> > >> > >> > a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
> > >> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -6,8
> > >> > >> > +6,8 @@ Required properties:
> > >> > >> >    - "fsl,imx1-pwm" for PWM compatible with the one
> > >> > >> > integrated on i.MX1
> > >> > >> >    - "fsl,imx27-pwm" for PWM compatible with the one
> > >> > >> > integrated on i.MX27
> > >> > >> >  - reg: physical base address and length of the controller's
> > >> > >> > registers -- #pwm-cells: should be 2. See pwm.txt in this
> > >> > >> > directory for a description of
> > >> > >> > -  the cells format.
> > >> > >> > +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs.
> > >> > >> > See pwm.txt
> > >> > >> > +  in this directory for a description of the cells format.
> > >> > >> >  - clocks : Clock specifiers for both ipg and per clocks.
> > >> > >> >  - clock-names : Clock names should include both "ipg" and
> > >> > >> > "per" See the clock consumer binding,
> > >> > >> > @@ -17,7 +17,7 @@ See the clock consumer binding,
> > >> > >> >  Example:
> > >> > >> >
> > >> > >> >  pwm1: pwm@53fb4000 {
> > >> > >> > -	#pwm-cells = <2>;
> > >> > >> > +	#pwm-cells = <3>;
> > >> > >> >  	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
> > >> > >> >  	reg = <0x53fb4000 0x4000>;
> > >> > >> >  	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> > >> > >> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > >> > >> > index d600fd5..c37d223 100644
> > >> > >> > --- a/drivers/pwm/pwm-imx.c
> > >> > >> > +++ b/drivers/pwm/pwm-imx.c
> > >> > >> > @@ -38,6 +38,7 @@
> > >> > >> >  #define MX3_PWMCR_DOZEEN		(1 << 24)
> > >> > >> >  #define MX3_PWMCR_WAITEN		(1 << 23)
> > >> > >> >  #define MX3_PWMCR_DBGEN			(1 << 22)
> > >> > >> > +#define MX3_PWMCR_POUTC			(1 << 18)
> > >> > >> >  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
> > >> > >> >  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
> > >> > >> >  #define MX3_PWMCR_SWR			(1 << 3)
> > >> > >> > @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct
> > >> > >> > pwm_chip *chip, if (enable)
> > >> > >> >  		cr |= MX3_PWMCR_EN;
> > >> > >> >
> > >> > >> > +	if (pwm->args.polarity == PWM_POLARITY_INVERSED)
> > >> > >> > +		cr |= MX3_PWMCR_POUTC;
> > >> > >> > +  
> > >> > >>
> > >> > >> This seems wrong to me, the config callback is meant for
> > >> > >> period/duty cycle only.  
> > > 
> > > Unfortunately, it also resets the PWM IP block and setups it again
> > > (by writing to PWMCR register).

Well, this is an implementation problem. If you were reading the
MX3_PWMCR register and masking it with MX3_PWMCR_POUTC to keep the
value set by ->set_polarity() that wouldn't be a problem.

> > > In that function we setup for
> > > example MX3_PWMCR_DOZEEN
> > > and MX3_PWMCR_DBGEN. Why cannot we setup polarity as well?

I think there's no real problem in setting the polarity again in
->config(), it's just that it feels weird to have it set twice (in
->set_polarity() and in ->config()).

> > > 
> > > 
> > > I've double checked the backlight and pwm code flow.
> > > 
> > > Please find following snippet:
> > > 
> > > [    0.135545] ######### imx_pwm_probe
> > > [    0.135581] PWM supports output inversion
> > > [    0.136864] ######### pwm_backlight_probe
> > > [    0.136913] backlight supply power not found, using dummy
> > > regulator [    0.136984] ######### imx_pwm_set_polarity 1
> > > [    0.136995] imx_pwm_set_polarity: polarity set to inverted cr:
> > > 0x40000 0xf08f8000
> > > [    0.137005] #########0 imx_pwm_config_v2 cr: 0x40000 
> > > [    0.137683] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> > > [    0.137693] #########2 imx_pwm_config_v2 cr: 0x1c20050
> > > [    0.137702] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> > > [    0.137711] @@@@@@@@@@ pwm_apply_state  
> 
> Maybe a bit more logs:
> 
> [    0.135451] ######### imx_pwm_probe
> [    0.135488] PWM supports output inversion
> [    0.136777] ######### pwm_backlight_probe
> [    0.136826] backlight supply power not found, using dummy regulator
> [    0.136893] ********* pwm_apply_state state->enabled: 0
> [    0.136902] ######### imx_pwm_set_polarity 1
> [    0.136913] imx_pwm_set_polarity: polarity set to inverted cr: 0x40000 0xf08f8000
> [    0.136923] #########0 imx_pwm_config_v2 cr: 0x40000
> [    0.137692] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> [    0.137701] #########2 imx_pwm_config_v2 cr: 0x1c20050
> [    0.137710] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> [    0.137720] @@@@@@@@@@ pwm_apply_state
> [    0.137856] ********* pwm_apply_state state->enabled: 0
> [    0.137869] #########0 imx_pwm_config_v2 cr: 0x1c20050
> [    0.138904] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> [    0.138913] #########2 imx_pwm_config_v2 cr: 0x1c20050
> [    0.138921] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> [    0.138928] @@@@@@@@@@ pwm_apply_state
> [    0.138940] ********* pwm_apply_state state->enabled: 1
> 					 ^^^^^^^^^^^^^^^^^^ this is called from
> 			pwm_backlight_power_on() from pwm_bl probe function
> 
> The problem here is not the lack of ->apply() callback, but the requirement to
> perform software reset on the pwm_v2 fifo when the pwm_v2 is NOT enabled (state->enabled: 0).

Not sure what a PWM fifo is, or which software reset you are talking
about. If you're talking about the disable()+set_polarity()+enable()
dance, then, this is required by some PWM controllers which do not
support changing the PWM polarity while the PWM is running.

> 
> As fair as I can see the pwm_state has following members: period, duty cycle, polarity and enabled.
> I'm fine to implement ->apply() callback, which would change above values.
> 
> However, there is a problem with ->config() (imx_pwm_config_v2 @ pwm-imx.c) and imx pwm_v2 software
> FIFO reset.

->config() will not be used if you implement ->apply(), and ->apply()
should take care of all the nasty details that should be taken care of
on your PWM controller.

Say for example that you need to disable the PWM before changing the
polarity, then your ->apply() function should check if the PWM is
enabled, if that's the case it should disable it, set the new polarity,
possibly re-apply the period and duty config and finally re-enable the
PWM.

> We can set polarity in any other kernel subsystem, which uses PWM (backlight in this example) and 
> then this setting would disappear when we call pwm_apply_state with state->enabled = 0 (as presented
> in the log). This imposes setting polarity at ->config when we enable the PWM (as this patch does).

That's really a driver problem, not a PWM user or PWM core problem. If
you have to take extra precautions when enabling the PWM (like
re-applying the polarity), then you can do that in your ->apply()
implementation.

> 
> 
> 
> > > 
> > > Here the pwm_backlight_probe calls set_polarity callback available
> > > in pwm - the polarity is set (the 0x40000 value).
> > > 
> > > The above operation is performed in pwm_apply_state (@
> > > drivers/pwm/core.c). In the same function, latter we call the
> > > pwm->chip->ops->config(), which is the pointer to config_v2.
> > > Since the PWM is not yet enabled, this function performs SW reset
> > > and PWM inversion setting is cleared.  
> > 
> > That function should not do that.   
> 
> I do agree that it shouldn't. Correct me if I'm wrong, but it seems like an 
> PWM HW requirement to perform the reset.
> 
> >It was probably already problematic
> > in the old times, it is definitely now with the atomic PWM stuff.  
> 
> The "atomic"[*] code (with ->apply() provided) will not solve this issue.

Of course it will solve the problem, because in ->apply() you're passed
all the information you need, and if you have to re-apply the polarity
setting, you can (which was not the case with the old pwm_ops
interface).

> 
> >   
> > > 
> > > Possible solutions:
> > > 
> > > 1. Leave the original patch from Bhuvanchandra as it was (I'm for
> > > this option)  
> > 
> > That really seems like a hack to me, and makes transition to the
> > atomic PWM API more complex.  
> 
> Could you be more specific here? 
> 
> As I mentioned before, the problem is not with the lack of
> "atomic" API.

And I really think it is.

> 
> For me the problem is with other subsystems (like pwm backlight)
> which do require polarity inversion to work properly.

Nope, it's just that, with the old pwm_ops interface, your driver was
not able to apply things in the right order. With the ->apply() it can.

> 
> > 
> > If we can't make it happen properly in the current state of affairs,  
> 
> We can set polarity properly with this patch. The only thing which needs fixing
> and another revision of the patch) is the removal of condition:
> 
> -       if (polarity == pwm->args.polarity)
> -               return 0;
> 
> at imx_pwm_set_polarity() function.

Yes, you can probably add even more hacks, but as Stefan said, it's
probably better to switch to the atomic interface, because by doing you
would greatly simplify the logic.

> 
> > we probably should first move to the atomic API.
> > 
> > It really should not be that hard, since we already do almost
> > everything in one function (imx_pwm_config_v2). We probably can
> > almost just assign that function to the new apply function pointer
> > and read information from the new state struct.  
> 
> We do need to configure polarity according to DT value during the pwm
> config_v2 configuration after PWM IP software reset.

And again, forget about ->config(), it should not be called if you
implement ->apply() (actually, you should even drop it completely). So
really, you should try implementing ->apply() and see what happens.

> 
> > 
> > There are examples for instance here:
> > https://patchwork.kernel.org/patch/7228221/  
> 
> The atomicity[*]:
> 
> - It seems to me that this "atomicity" is just embracing all the ->enable, ->disable
> and ->set_polarity in one -> apply callback. Is this just conceptual clean up or is
> there any other reason for it (I'm just curious) ?

No, it's not just a conceptual cleanup. Some hardware are capable of
updating the PWM config atomically (which means they will update the
config at the end of the current period cycle), and by doing that we
also prevent any glitches on the PWM signal.
With the old API, this was simply impossible to do, because the
enable/disable, set_polarity and config calls were separated. With the
atomic API, we can.

Now, let's say your controller is not guaranteeing atomicity. It's
still interesting to implement the ->apply() function, because this way
you can handle all those complex sequences that are required on some HW.

To sum-up, I really think you should listen to Stefan and try to
implement the atomic hook (AKA ->apply()).

Regards,

Boris
