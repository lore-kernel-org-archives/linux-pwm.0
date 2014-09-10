From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4] pwm: lpc32xx - Add a driver for the motor PWM
Date: Wed, 10 Sep 2014 18:28:39 +0200
Message-ID: <3043402.gA1yIrlkCZ@wuerfel>
References: <1410363822-22151-1-git-send-email-alban.bedel@avionic-design.de> <12709842.iga6ki5KTS@wuerfel> <20140910175941.5c44837f@avionic-0020>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140910175941.5c44837f@avionic-0020>
Sender: linux-kernel-owner@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Roland Stigge <stigge@antcom.de>
List-Id: linux-pwm@vger.kernel.org

On Wednesday 10 September 2014 17:59:41 Alban Bedel wrote:
> On Wed, 10 Sep 2014 17:51:36 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Wednesday 10 September 2014 17:43:42 Alban Bedel wrote:
> > > +- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> > > +  the cells format. The only third cell flag supported by this binding is
> > > +  PWM_POLARITY_INVERTED.
> > 
> > If you don't have multiple pwm outputs or programmable period, I would say it
> > should use #pwm-cells=<1> and only pass the polarity.
> 
> There is 3 channel, so 3 PWM from the API POV, and the period is
> independently programmable for each one.

Then you should put the channel number into the first cell and the period
length into the second cell, as the pwm.txt document says.

	Arnd
