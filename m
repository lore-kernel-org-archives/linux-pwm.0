From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 17 Dec 2013 14:08:17 +0100
Message-ID: <2074242.bGmqYDKUOT@flatron>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com> <1500339.E8bGm7xZUi@flatron> <20131217130435.GV4360@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131217130435.GV4360@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, mark.rutland@arm.com, s.hauer@pengutronix.de, galak@codeaurora.org, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, matt.porter@linaro.org, rob@landley.net, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Alison Wang <b18965@freescale.com>, Jingchang Lu <b35083@freescale.com>
List-Id: linux-pwm@vger.kernel.org

On Tuesday 17 of December 2013 13:04:35 Russell King - ARM Linux wrote:
> On Tue, Dec 17, 2013 at 01:54:35PM +0100, Tomasz Figa wrote:
> > On Tuesday 17 of December 2013 13:45:06 Thierry Reding wrote:
> > > I fail to see how that would eliminate the problem with the types. That
> > > said I don't actually see sparse complaining about any type mismatches.
> > > That's probably because the various macros implicitly cast to u32.
> > 
> > Well, in BE variant you would read the register using __raw_readl() into
> > a __be32 and then get an u32 from be32_to_cpu() and return it. Similarly
> > for writes
> 
> __raw_readl() returns a u32, so you'll get a warning trying to assign a
> u32 to a __be32.
> 
> We do have ioread32() and ioread32be() which do the appropriate conversion,
> as well as the write versions too.  They both include the barrier if you're
> overly concerned about that.

Nice. I wasn't aware of their existence. Thanks.

Best regards,
Tomasz
