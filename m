From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add different PWM output types support
Date: Mon, 23 Sep 2019 22:43:43 -0700
Message-ID: <20190924054343.GA12462@codeaurora.org>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
 <20190916140146.GC7488@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190916140146.GC7488@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>, Sandeep Patil <sspatil@google.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Sep 16, 2019 at 04:01:46PM +0200, Thierry Reding wrote:
> On Fri, Sep 13, 2019 at 03:57:43PM -0700, Guru Das Srinagesh wrote:
> > From: Fenglin Wu <fenglinw@codeaurora.org>
> > 
> > Normally, PWM channel has fixed output until software request to change
> > its settings. There are some PWM devices which their outputs could be
> > changed autonomously according to a predefined pattern programmed in
> > hardware. Add pwm_output_type enum type to identify these two different
> > PWM types and add relevant helper functions to set and get PWM output
> > types and pattern.
> > 
> > Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e
> > Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/pwm/core.c  | 26 ++++++++++++++++++++
> >  drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/pwm.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 146 insertions(+)
> 
> This doesn't seem right to me. Are you describing a PWM pin that's
> actually driven in GPIO mode? We usually configure that using pinctrl.
> 
> Thierry

Sorry, let me clarify.

Some Qualcomm PMICs have a PWM block called the Light Pulse Generator (LPG).
This block allows for the generation of a HW-controlled PWM "pattern", i.e. a
sequential altering of duty cycle, in addition to the normal PWM "fixed" duty
cycle operation, which is what the framework does currently. This pattern is
user-configurable in the form of a look-up table in the devicetree. The LPG's
registers have to be configured with the data in the look up table in order to
start the generation of the pattern. An example of a pattern is the "breath"
pattern, which simply ramps up the duty cycle and then ramps it down.

This "pattern" mode is what has been defined as PWM_OUTPUT_MODULATED in this
patch. I see that the use of the term "modulated" is misleading - a more
accurate term would be PWM_OUTPUT_PATTERN perhaps.

This patch merely adds framework support to differentiate between the "fixed"
and "pattern" modes of operation. Actions such as configuring the LPG with the
devicetree pattern and setting it up for generating the pattern are performed
in the driver only if the output type is read as "pattern" and not otherwise.
