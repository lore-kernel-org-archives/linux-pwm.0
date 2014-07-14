From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: Re: [PATCH v2] hwmon: pwm-fan: Add pwm-fan driver
Date: Mon, 14 Jul 2014 16:25:25 +0200
Message-ID: <20140714142525.GB7668@distanz.ch>
References: <1405345835-17089-1-git-send-email-k.debski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405345835-17089-1-git-send-email-k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On 2014-07-14 at 15:50:35 +0200, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> The pwm-fan driver enables control of fans connected to PWM lines.
> This driver uses the PWM framework, so it is compatible with all
> PWM devices that provide drivers through the PWM framework.
> 
> Signed-off-by: Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes since v1:
> - added documentation to Documentation/hwmon
> - fix checkpatch errors
> 	- added extra description to Kconfig
> 	- removed whitespace errors
> - include files rearranged to be in alphabetical order
> - remove unused sysfs entry pwm1_enable
> - changed the behavior of the set_pwm function
> 	- when 0 PWM value is set pwm_disable is run
> 	- pwm_config return value is checked for errors
> - use of ATTRIBUTE_GROUPS was added
> - removed "Not enouch memory" error message
> - fixed probe return value in case of devm_of_pwm_get error
> - changed hwmon_device_register_with_groups to
>   devm_hwmon_device_register_with_groups
> - changes suspend/resume to use pwm_disable/enable
> - removed unnecessary CONFIG_PM_SLEEP ifdefs

pwm_fan_suspend and pwm_fan_resume should still be enclosed in #ifdef
CONFIG_PM_SLEEP, otherwise you'll get 'defined but not used' compiler
warnings when building without CONFIG_PM being set.

Cheers
Tobias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
