From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Wed, 17 Oct 2018 10:58:18 -0500
Message-ID: <20181017155818.GA21971@bogus>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
 <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
 <20181016220437.GB31973@mithrandir>
 <7fc1168d-a840-032a-c0a9-2a610127c484@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7fc1168d-a840-032a-c0a9-2a610127c484@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Wesley Terpstra <wesley@sifive.com>, linus.walleij@linaro.org, palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org, linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Oct 16, 2018 at 03:20:34PM -0700, Atish Patra wrote:
> On 10/16/18 3:04 PM, Thierry Reding wrote:
> > On Tue, Oct 16, 2018 at 10:31:42AM -0700, Paul Walmsley wrote:
> > > 
> > > On 10/16/18 4:01 AM, Thierry Reding wrote:
> > > > On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
> > > > > On 10/10/18 6:49 AM, Thierry Reding wrote:
> > > > > > On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> > > > > > > +Required properties:
> > > > > > > +- compatible: should be one of
> > > > > > > +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> > > > > > What's the '0' in here? A version number?
> > > > > > 
> > > > > I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive Guys
> > > > > decided mark it as version 0.
> > > > > 
> > > > > @Wesly: Please correct me if I am wrong.
> > > > It seems fairly superfluous to me to have a version number in additon to
> > > > the fu540-c000, which already seems to be the core plus some sort of
> > > > part number. Do you really expect there to be any changes in the SoC
> > > > that would require a different compatible string at this point? If the
> > > > SoC has taped out, how will you ever get a different version of the PWM
> > > > IP in it?
> > > > 
> > > > I would expect any improvements or changes to the PWM IP to show up in a
> > > > different SoC generation, at which point it would be something like
> > > > "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
> > > > the numbering is.
> > > 
> > > 
> > > The "0" suffix refers to a revision number for the underlying PWM IP block.
> > > 
> > > It's certainly important to keep that version number on the "sifive,pwm0"
> > > compatible string that doesn't have the chip name associated with it.
> > 
> > Isn't the hardware identified by "sifive,pwm0" and "sifive,fu540-c000"
> > effectively identical?
> 
> Yes.
> 
> Is there a need to have two compatible strings
> > that refer to the exact same hardware?
> > 
> 
> The DT in the hardware has only sifive,pwm0. I have added
> "sifive,fu540-c000" as that was concluded as the correct compatible string
> from platform level interrupt controller patch(PLIC) discussion.
> 
> (http://lists.infradead.org/pipermail/linux-riscv/2018-August/001135.html)
> 
> "sifive,pwm0" is required to until all the Unleashed SoC gets an updated
> firmware with correct compatible string "sifive,fu540-c000". I agree this is
> a mess. But we have to carry it until all every DT(corresponding to each
> driver) is finalized. I guess SiFive will release a firmware update that
> contains all the updated DT once that is done. We can get rid of all the
> redundant compatible strings at that time.

I don't want to repeat compatible string discussions on each and every 
IP block. I already have to do this with some vendors.

The RiscV vendors' needs and design flow are a bit different from 
traditional SoC vendors AIUI for the last discussion. If you need to do 
something that doesn't follow normal conventions, that's fine. Just 
please document a convention that works for you. This should explain 
where the '0' above comes from for example. And I'm not a fan of s/w 
folks making up version numbers.

Rob
