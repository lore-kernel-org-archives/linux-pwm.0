From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH v9 0/2] PWM: pwm-atmel: add PWM controller driver
Date: Wed, 18 Dec 2013 09:21:12 +0800
Message-ID: <52B0F888.2000905@atmel.com>
References: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
 <20131217103034.GE13823@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131217103034.GE13823@ulmo.nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, galak@codeaurora.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 12/17/2013 06:30 PM, Thierry Reding wrote:
> On Fri, Dec 13, 2013 at 02:41:48PM +0800, Bo Shen wrote:
>> This patch series add Atmel PWM controller driver support.
>>
>> Changes in v9:
>>    - Address the comments from Thierry Reding
>
> Hi,
>
> I've pushed a slightly modified version of this series. There were a few
> minor whitespace/coding style issues, but perhaps more importantly I've
> modified the period change check to be done earlier and in a more
> generic way.

Thanks for your work.

> Can you please check that the version I've pushed to the for-next branch
> still works for you?

Tested OK with pwm leds and pwm backlight.
Thanks again.

> Thanks,
> Thierry

Best Regards,
Bo Shen
