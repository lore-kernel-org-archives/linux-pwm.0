From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: add MediaTek display PWM bindings
Date: Thu, 2 Jul 2015 16:15:07 +0800
Message-ID: <CAGS+omAhnFzgqBrdCGjD8f83oL3GaigCVRvh_vVW07Vs302HHA@mail.gmail.com>
References: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
 <1435590211-38854-2-git-send-email-yh.huang@mediatek.com>
 <1435591483.21804.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1435591483.21804.2.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jun 29, 2015 at 11:24 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> I am sorry for forgetting to remove Change-Id in [PATCH v3 1/2] and
> [PATCH v3 1/2].
>
> Regards,
> YH Huang
>
> On Mon, 2015-06-29 at 23:03 +0800, YH Huang wrote:
>> Document the device-tree binding of MediatTek display PWM.
>> The clock "main" and "mm" are used to generate PWM signals.
>> The PWM has one channel to control the backlight brightness for display.
>> It supports MT8173 and MT6595.
>>
>> Change-Id: I194ca88b4e4cd01a28b8701e07e86ea6941e5292
>> Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>> new file mode 100644
>> index 0000000..355b755
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>> @@ -0,0 +1,24 @@
>> +MediaTek display PWM controller
>> +
>> +Required properties:
>> + - compatible: should be "mediatek,<name>-disp-pwm"
>> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
>> +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
>> + - reg: physical base address and length of the controller's registers
>> + - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>> +   the cell format
>> + - clocks: phandle and clock specifier of the PWM reference clock
>> + - clock-names: must contain the following
>> +   - "main": clock used to generate PWM signals
>> +   - "mm": sync signals from the modules of mmsys
>> +
>> +Example:
>> +     pwm0: pwm@1401e000 {
>> +             compatible = "mediatek,mt8173-disp-pwm",
>> +                          "mediatek,mt6595-disp-pwm";
>> +             reg = <0 0x1401e000 0 0x1000>;
>> +             #pwm-cells = <2>;
>> +             clocks = <&mmsys MM_DISP_PWM026M>,
>> +                      <&mmsys MM_DISP_PWM0MM>;

These should be CLK_MM_DISP...

Thanks!
-Dan

>> +             clock-names = "main", "mm";
>> +     };
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
