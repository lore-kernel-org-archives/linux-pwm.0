From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Date: Mon, 24 Feb 2020 11:14:48 +0000
Message-ID: <20200224111448.GS3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1581895931-6056-3-git-send-email-jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Sun, 16 Feb 2020, Jeff LaBundy wrote:

> This patch adds core support for the Azoteq IQS620A, IQS621, IQS622,
> IQS624 and IQS625 multi-function sensors.
> 
> Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v5:
>   - Merged iqs62x-core.c and iqs62x-tables.c into a single iqs62x.c
>   - Corrected spelling of "data sheet" to "datasheet"
>   - Added one line of whitespace in various places to improve readability
>   - Replaced iqs62x->map with iqs62x->regmap throughout
>   - Added the prox_settings member to the iqs62x_dev_desc struct and eliminated
>     the ternary operator in iqs62x_dev_init to determine SAR UI enable register
>     address
>   - Added a comment in iqs62x_dev_init to explain the background for the bounds
>     checking done on the IQS624/625 interval divider
>   - Added #defines for the delays used within iqs62x_dev_init
>   - Renamed iqs62x_fw_prs and iqs62x_fw_cb to iqs62x_firmware_parse and
>     iqs62x_firmware_load, respectively
>   - Updated the call to devm_mfd_add_devices to use PLATFORM_DEVID_NONE instead
>     of -1 and printed "sub-devices" instead of "devices" in the error message
>   - Dropped #defines for mfd_cell names in favor of the actual string names and
>     collapsed mfd_cells with no other members into one line
>   - Demoted iqs62x_devs to a static array as it is not used by any sub-devices
>   - Removed unnecessary { IQS620A_DEV, ... } enum and IQS62X_NUM_DEV #define
>   - Removed the soft reset and associated delay in iqs62x_probe to preserve any
>     PWM-related changes made by a bootloader
>   - Updated the comments in iqs62x_probe to highlight the significance of blank
>     calibration registers and why the outer loop may be exited early
>   - Made the first call to regmap_update_bits in iqs62x_suspend consistent with
>     other instances in the series that set a single bit by passing all ones for
>     the value instead of the mask
> 
> Changes in v4:
>   - None
> 
> Changes in v3:
>   - None
> 
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Updated iqs62x_dev_init to account for 4/8/16-MHz clock divider in start-up
>     delays and replaced ATI timeout routine with regmap_read_poll_timeout
>   - Added an error message to iqs62x_irq in case device status fails to be read
>   - Replaced sw_num member of iqs62x_core with a local variable in iqs62x_probe
>     as the former was unused anywhere else
>   - Added comments throughout iqs62x_probe to clarify how devices are matched
>     based on the presence of calibration data
>   - Inverted the product and software number comparison logic in iqs62x_probe
>     to avoid an else...continue branch
>   - Changed iqs62x_probe from .probe callback to .probe_new callback, thereby
>     eliminating the otherwise unused iqs62x_id array
>   - Moved iqs62x_suspend and iqs62x_resume below iqs62x_remove
>   - Eliminated tabbed alignment of regmap_config and i2c_driver struct members
>   - Added register definitions for register addresses used in iqs621_cal_regs,
>     iqs620at_cal_regs and iqs62x_devs arrays
>   - Removed of_compatible string from IQS622 mfd_cell struct as its proximity
>     (now ambient light) sensing functionality need not be represented using a
>     child node
>   - Dissolved union in iqs62x_event_data to allow simultaneous use of ir_flags
>     and als_flags
>   - Removed temp_flags member of iqs62x_event_data, IQS62X_EVENT_TEMP register
>     enumeration and IQS62X_EVENT_UI_HI/LO from iqs620a_event_regs (thereby re-
>     ducing IQS62X_EVENT_SIZE to 10) as they were unused
> 
>  drivers/mfd/Kconfig        |   13 +
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/iqs62x.c       | 1063 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/iqs62x.h |  139 ++++++
>  4 files changed, 1216 insertions(+)
>  create mode 100644 drivers/mfd/iqs62x.c
>  create mode 100644 include/linux/mfd/iqs62x.h

Well done Jeff.  Good job.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
