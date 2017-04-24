From: Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Date: Mon, 24 Apr 2017 20:55:26 +0800
Message-ID: <20170424125436.GA3949@mint-host>
References: <20170215144531.GA39000@ubuntu>
 <20170406161835.GA19312@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170406161835.GA19312@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Yang Ling <gnaygnil@gmail.com>, Marcin Nowakowski <marcin.nowakowski@imgtec.com>, Keguang Zhang <keguang.zhang@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-pwm@vger.kernel.org

Hi, Thierry,

I am sorry for the late reply.

For some historical reasons, Loongson1x series SoCs is still unable to support the device tree.
So drivers need to rely on some register-related macro definitions in loongson1.h(arch/mips/include/asm/mach-loongson32/loongson1.h).
The driver is currently tested on the Loongson1C development board.
We plan to solve the problem together after the SoCs bootloader supports the device tree.

Thanks for your friendly reminder.

Yang

On Thu, Apr 06, 2017 at 06:18:35PM +0200, Thierry Reding wrote:
> On Wed, Feb 15, 2017 at 10:45:31PM +0800, Yang Ling wrote:
> > Add support for the PWM controller present in Loongson1 family of SoCs.
> > 
> > Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> > 
> > ---
> > V2:
> >   Remove ls1x_pwm_channel.
> >   Remove period_ns/duty_ns check.
> >   Add return values check.
> > ---
> >  drivers/pwm/Kconfig         |   9 +++
> >  drivers/pwm/Makefile        |   1 +
> >  drivers/pwm/pwm-loongson1.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 158 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-loongson1.c
> 
> Looks like this doesn't compile because it uses register definitions
> from loongson1.h that aren't what the driver expects. Looks like the
> driver wants parameterized ones, but those present in the kernel are
> not.
> 
> Any plans on fixing that? How did you build-test this?
> 
> Thierry
