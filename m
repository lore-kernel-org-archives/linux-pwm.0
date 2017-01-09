From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/8] MFD: add bindings for STM32 Timers driver
Date: Mon, 9 Jan 2017 11:59:39 -0600
Message-ID: <20170109175939.3wpidwkktfxo3x5t@rob-hp-laptop>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-2-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1483608344-9012-2-git-send-email-benjamin.gaignard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linus.walleij@linaro.org, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, gerald.baeza@st.com, fabrice.gasnier@st.com, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, jic23@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 05, 2017 at 10:25:37AM +0100, Benjamin Gaignard wrote:
> Add bindings information for STM32 Timers
> 
> version 6:
> - rename stm32-gtimer to stm32-timers
> - change compatible
> - add description about the IPs
> 
> version 2:
> - rename stm32-mfd-timer to stm32-gptimer
> - only keep one compatible string
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/mfd/stm32-timers.txt       | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt

Acked-by: Rob Herring <robh@kernel.org>
