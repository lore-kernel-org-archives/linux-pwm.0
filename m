From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIHB3bTogQWRkIG1jMTN4eHggcHdtIGRyaXZlci4=?=
Date: Wed, 27 Nov 2013 19:54:24 +0400
Message-ID: <1385567664.228570055@f131.i.mail.ru>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?RGVuaXMgQ2FyaWtsaQ==?= <denis@eukrea.com>
Cc: linux-pwm@vger.kernel.org, =?UTF-8?B?U2FtdWVsIE9ydGl6?= <sameo@linux.intel.com>, devicetree@vger.kernel.org, =?UTF-8?B?Um9iIEhlcnJpbmc=?= <rob.herring@calxeda.com>, =?UTF-8?B?VGhpZXJyeSBSZWRpbmc=?= <thierry.reding@gmail.com>, =?UTF-8?B?R3JhbnQgTGlrZWx5?= <grant.likely@linaro.org>, =?UTF-8?B?U2hhd24gR3Vv?= <shawn.guo@linaro.org>, =?UTF-8?B?TGVlIEpvbmVz?= <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello.

...
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt    |   19 ++
>  drivers/mfd/mc13xxx-core.c                         |   11 ++
>  drivers/pwm/Kconfig                                |    6 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-mc13xxx.c                          |  205 ++++++++++++++++++++
>  include/linux/mfd/mc13783.h                        |    2 +
>  6 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
>  create mode 100644 drivers/pwm/pwm-mc13xxx.c
> 
> diff --git a/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
> new file mode 100644
> index 0000000..a1394d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale mc13xxx series PWM drivers.
> +
> +Supported PWMs:
> +mc13892 series
> +mc34708 series

MC13892 does not have a dedicated PWM.
You can probably use the existing driver mc13xxx-led driver.

---
