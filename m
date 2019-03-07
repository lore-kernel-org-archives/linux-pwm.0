From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 0/7] FlexTimer Module Quadrature decoder counter
Date: Thu, 7 Mar 2019 21:03:13 +0900
Message-ID: <20190307120224.GC7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Havelange <patrick.havelange@essensium.com>, jic23@kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 06, 2019 at 12:12:01PM +0100, Patrick Havelange wrote:
> This patch serie is to be applied on top of 
> https://patchwork.kernel.org/project/linux-iio/list/?series=147
> (a more recent version of the serie is available here : 
> https://gitlab.com/vilhelmgray/iio/tree/generic_counter_v10 )
> 
> Main changes in v2: 
> The code is a bit simpler, thanks to more use of devm_* functions.
> The polling/32bit signed version has been dropped, as not needed and
> no other driver is doing that.
> 
> 
> Patrick Havelange (7):
>   include/fsl: add common FlexTimer #defines in a separate header.
>   drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
>   drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer
>     #defines
>   dt-bindings: counter: ftm-quaddec
>   counter: add FlexTimer Module Quadrature decoder counter driver
>   counter: ftm-quaddec: Documentation: Add specific counter sysfs
>     documentation
>   LS1021A: dtsi: add ftm quad decoder entries
> 
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec |  16 +
>  .../bindings/counter/ftm-quaddec.txt          |  18 +
>  arch/arm/boot/dts/ls1021a.dtsi                |  28 ++
>  drivers/clocksource/timer-fsl-ftm.c           |  15 +-
>  drivers/counter/Kconfig                       |   9 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ftm-quaddec.c                 | 356 ++++++++++++++++++
>  drivers/pwm/pwm-fsl-ftm.c                     |  44 +--
>  include/linux/fsl/ftm.h                       |  88 +++++
>  9 files changed, 519 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
>  create mode 100644 drivers/counter/ftm-quaddec.c
>  create mode 100644 include/linux/fsl/ftm.h
> 
> -- 
> 2.19.1

Patrick,

I see you dropped the polling support in this version. If the need
arises in the future, we can discuss a possible ways of resolving your
latency issues; I imagine interrupts during overflow/underflow events to
be a common behavior among counter devices so those too may result in
latency issues as you discovered in your case.

Jonathan,

If you are satisfied with the changes in this patchset, let me know
which patches you like and I'll add respective Reviewed-by tags for you
for the next Counter subsystem introduction patchset submission.

William Breathitt Gray
