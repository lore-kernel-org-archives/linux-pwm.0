From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 2/2] drivers: pwm: pwm-atmel: enable pwm on sama5d2
Date: Fri, 3 Mar 2017 11:53:17 +0200
Message-ID: <a4ce6e72-bc67-cb53-6c45-910a7c1497e0@microchip.com>
References: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
 <1488278415-2786-3-git-send-email-claudiu.beznea@microchip.com>
 <20170303062120.uippq2ajtnrxfcx5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170303062120.uippq2ajtnrxfcx5@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, boris.brezillon@free-electrons.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, thierry.reding@gmail.com, alexandre.belloni@free-electrons.com, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi,


On 03.03.2017 08:21, Rob Herring wrote:
> On Tue, Feb 28, 2017 at 12:40:15PM +0200, Claudiu Beznea wrote:
>> sama5d2 can use the same atmel_pwm_data as sama5d3.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>>  drivers/pwm/pwm-atmel.c                             | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> index 02331b9..c8c831d 100644
>> --- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>    - compatible: should be one of:
>>      - "atmel,at91sam9rl-pwm"
>>      - "atmel,sama5d3-pwm"
>> +    - "atmel,sama5d2-pwm"
> Perhaps sama5d3 should be a fallback, then you don't need a driver 
> change.
>
> Rob

sama5d2 PWM controller have additional features. We intend to support
some of these. This is why I choose to add specific compatible string
for it.

Thank you,
Claudiu Beznea
