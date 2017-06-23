From: John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 0/6] mediatek: pwm driver add MT2712/MT7622 support
Date: Fri, 23 Jun 2017 07:48:28 +0200
Message-ID: <f2ddc1ea-ca0d-4375-c2c6-e3f6f35a0834@phrozen.org>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhi Mao <zhi.mao@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: zhenbao.liu@mediatek.com, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, sean.wang@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, yt.shen@mediatek.com, yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 23/06/17 07:08, Zhi Mao wrote:
> change in v2:
> 1. add error check for enable colock control flow
> 2. use "goto err_clk(main/top)" coding style, for preparing clk error case
> 3. remove comments inline /*===*/
> 4. move "PWM_CLK_DIV_MAX" modification to its own patch
> 5. move pwm source clock selection to its own patch

Hi,
thanks for updating the series, i will give it a quick test on MT7623 today
     John

> Zhi Mao (6):
>    pwm: kconfig: modify mediatek information
>    pwm: mediatek: fix pwm source clock selection
>    pwm: mediatek: fix clock control issue
>    pwm: bindings: add MT2712/MT7622 information
>    pwm: mediatek: add PWM_CLK_DIV_MAX
>    pwm: mediatek: add MT2712/MT7622 support
>
>   .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
>   drivers/pwm/Kconfig                                |    2 +-
>   drivers/pwm/pwm-mediatek.c                         |  132 ++++++++++++++------
>   3 files changed, 103 insertions(+), 37 deletions(-)
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
