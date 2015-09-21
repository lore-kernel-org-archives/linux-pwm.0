From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: pwm-bl: regression on all pxa platforms
Date: Mon, 21 Sep 2015 22:41:23 +0200
Message-ID: <87vbb3pkss.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

Since a bit of time, the PWM backlight based pxa platforms are broken.
All of these platforms rely on a registering such as the one in [1].

At least I think the commit 68feaca0b13e ("backlight: pwm: Handle EPROBE_DEFER
while requesting the PWM") breaks my platforms because :
 (a) no pwm table is added (legacy platforms)
 (b) in this case, in pwm_get(), pmw_lookup_list is empty, and therefore chosen
      == NULL, and therefore pwm_get() returns NULL, and pwm_get() return
      -EPROBE_DEFER
 (c) as a consequence, this code is unreachable in pwm_bl.c :
	if (IS_ERR(pb->pwm)) {
		ret = PTR_ERR(pb->pwm);
		dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
		if (ret == -EPROBE_DEFER)
			goto err_alloc;

		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
		pb->legacy = true;
		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");

Could you either revert 68feaca0b13e or find a better solution to repair the
legacy platorms please ?

Cheers.

-- 
Robert

[1] Backlight registration
static struct platform_pwm_backlight_data cm_x300_backlight_data = {
	.pwm_id		= 2,
	.max_brightness	= 100,
	.dft_brightness	= 100,
	.pwm_period_ns	= 10000,
	.enable_gpio	= -1,
};

static struct platform_device cm_x300_backlight_device = {
	.name		= "pwm-backlight",
	.dev		= {
		.parent = &pxa27x_device_pwm0.dev,
		.platform_data	= &cm_x300_backlight_data,
	},
};

static void cm_x300_init_bl(void)
{
	platform_device_register(&cm_x300_backlight_device);
}
