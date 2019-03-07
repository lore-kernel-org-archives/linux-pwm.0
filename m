From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add specific
 counter sysfs documentation
Date: Thu, 7 Mar 2019 20:42:16 +0900
Message-ID: <20190307114216.GB7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-7-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-7-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 06, 2019 at 12:12:07PM +0100, Patrick Havelange wrote:
> This adds documentation for the specific prescaler entry.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes v2
>  - Add doc for prescaler entry
> ---
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> new file mode 100644
> index 000000000000..2da629d6d485
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file. Values are delimited by
> +		newline characters.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/prescaler
> +KernelVersion:	5.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configure the prescaler value associated with Count Y.
> +		On the FlexTimer, the counter clock source passes through a
> +		prescaler that is a 7-bit counter. This acts like a clock
> +		divider.
> -- 
> 2.19.1

Hmm, prescalers seem common enough among counter devices to permit these
attributes to be listed in the sysfs-bus-counter documentation file.
However, I'd like to wait until we get another counter driver for a
device with a prescaler before we make that move. From there, we'll have
a better vantage point to determine a fitting standard prescaler
attribute behavior.

So for now, we'll keep these attributes documented here in the
sysfs-bus-counter-ftm-quaddec file, until the time comes to broach the
discussion again.

William Breathitt Gray
