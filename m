From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM
 documentation
Date: Tue, 27 Aug 2019 11:20:18 -0500
Message-ID: <20190827162018.GA11135@bogus>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 14 Aug 2019 20:46:10 +0800, Baolin Wang wrote:
> Add Spreadtrum PWM controller documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Fix some typos.
>  - Move assigned-clocks to be optional.
> 
> Changes from v1:
>  - Use assigned-clock-parents and assigned-clocks to set PWM clock parent.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
