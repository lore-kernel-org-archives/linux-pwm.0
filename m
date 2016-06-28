From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Tue, 28 Jun 2016 16:31:40 +0100
Message-ID: <20160628153140.GD29166@dell>
References: <1466193495-95801-1-git-send-email-briannorris@chromium.org>
 <1466193495-95801-3-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466193495-95801-3-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, 17 Jun 2016, Brian Norris wrote:

> The EC_CMD_PWM_{GET,SET}_DUTY commands allow us to control a PWM that=
 is
> attached to the EC, rather than the main host SoC. The API provides
> functionality-based (e.g., keyboard light, backlight) or index-based
> addressing of the PWM(s). Duty cycles are represented by a 16-bit val=
ue,
> where 0 maps to 0% duty cycle and U16_MAX maps to 100%. The period
> cannot be controlled.
>=20
> This command set is more generic than, e.g.,
> EC_CMD_PWM_{GET,SET}_KEYBOARD_BACKLIGHT and could possibly used to
> replace it on future products.
>=20
> Let's update the command header to include the definitions.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v3:
>  * convert from 65535 to 0xffff
>=20
> v2:
>  * no changes
> ---
>  include/linux/mfd/cros_ec_commands.h | 31 ++++++++++++++++++++++++++=
+++++
>  1 file changed, 31 insertions(+)

=46or my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>
 =20
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd=
/cros_ec_commands.h
> index 13b630c10d4c..7e7a8d4b4551 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -949,6 +949,37 @@ struct ec_params_pwm_set_fan_duty {
>  	uint32_t percent;
>  } __packed;
> =20
> +#define EC_CMD_PWM_SET_DUTY 0x25
> +/* 16 bit duty cycle, 0xffff =3D 100% */
> +#define EC_PWM_MAX_DUTY 0xffff
> +
> +enum ec_pwm_type {
> +	/* All types, indexed by board-specific enum pwm_channel */
> +	EC_PWM_TYPE_GENERIC =3D 0,
> +	/* Keyboard backlight */
> +	EC_PWM_TYPE_KB_LIGHT,
> +	/* Display backlight */
> +	EC_PWM_TYPE_DISPLAY_LIGHT,
> +	EC_PWM_TYPE_COUNT,
> +};
> +
> +struct ec_params_pwm_set_duty {
> +	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY =3D 100% */
> +	uint8_t pwm_type;  /* ec_pwm_type */
> +	uint8_t index;     /* Type-specific index, or 0 if unique */
> +} __packed;
> +
> +#define EC_CMD_PWM_GET_DUTY 0x26
> +
> +struct ec_params_pwm_get_duty {
> +	uint8_t pwm_type;  /* ec_pwm_type */
> +	uint8_t index;     /* Type-specific index, or 0 if unique */
> +} __packed;
> +
> +struct ec_response_pwm_get_duty {
> +	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY =3D 100% */
> +} __packed;
> +
>  /*******************************************************************=
**********/
>  /*
>   * Lightbar commands. This looks worse than it is. Since we only use=
 one HOST

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
