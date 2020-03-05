From: Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Inverted PWM output on iMX6
Date: Thu, 5 Mar 2020 13:22:32 +0000
Message-ID: <20200305132232.1aced378@ub1910>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi folks,

I recently ran into an issue using the pwm-fan driver with an inverted
PWM output on iMX6.

The fan is defined in the device tree as follows:

	fan0: pwm-fan {
		compatible = "pwm-fan";
		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
		...
	}

In pwm_imx27_probe() the support for a third `flags` argument in a pwm
reference is enabled:

	imx->chip.of_xlate = of_pwm_xlate_with_flags;
	imx->chip.of_pwm_n_cells = 3;

However, the flag is ignored and the output is not inverted.

By adding some prints I saw that when of_pwm_xlate_with_flags() is
called, args->args_count is 2 instead of 3.

Looking at the definition of the pwm device itself in imx6qdl.dtsi I
can see that the number of cells in a pwm reference is set to 2 not 3:

	pwm2: pwm@2084000 {
		#pwm-cells = <2>;
		...
	};

That seems to be preventing a third argument from being passed.

I can change `#pwm-cells` to <3> and then everything works for my
device but I'm not sure that is the correct solution for everyone. That
would require all pwm references on iMX6 devices to use 3 cells. The
code in of_pwm_xlate_with_flags() seems to be built to handle either 2
or 3 argument cells but I can't see any way to allow this choice in the
device tree.

If the solution is to set `#pwm-cells` to <3> I'm happy to send a patch
which does this and updates all pwm references in device trees which
include `imx6dql.dtsi`. Before I do that I'd like to know that it's the
correct approach though.

For context I've confirmed this is the case in Linux 5.4 and that the
relevant files haven't changed between that release and 5.6.0-rc4.

Thanks,

-- 
Paul Barker
Konsulko Group
