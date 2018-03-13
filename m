From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
Date: Tue, 13 Mar 2018 14:05:34 +0000
Message-ID: <f001134a-987d-2491-a22e-d1d634f7b024@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-4-andre.przywara@arm.com>
 <20180307074516.dbak7ztkua4p7mr5@flea.lan>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBQVVT7KQKGQEXWZECBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180307074516.dbak7ztkua4p7mr5-ZC1Zs529Oq4@public.gmane.org>
Content-Language: en-GB
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Maxime,

thanks for looking into this and for the Acks!

On 07/03/18 07:45, Maxime Ripard wrote:
> On Wed, Mar 07, 2018 at 02:07:17AM +0000, Andre Przywara wrote:
>> While the PWM IP in the Allwinner H6 SoC is fully compatible to those
>> used in older SoCs (H3, A64), it features a dedicated reset line which
>> needs to be de-asserted.
>> Add support for an optional "resets" DT property in our pwm-sun4i probe
>> routine, and assert and de-assert the reset line, where needed.
>> This allows to enable PWM support on the H6.
> 
> This isn't optional then. It's mandatory on the H6, and unneeded on
> everything else. This is what we should have.

So are you aiming at:
	if (of_device_is_compatible(np, "allwinner,sun50i-h6-pwm")) {
		... devm_reset_control_get() ...

I guess this is preferable over coding something based on a new member
in struct sun4i_pwm_data?

Cheers,
Andre.
