From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Date: Wed, 13 Feb 2019 11:51:44 +0100
Message-ID: <72cab2a3-976a-44c6-5596-fd4e443ff2e8@st.com>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
 <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
 <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gMi8xMi8xOSAxMDowMyBBTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gSGVsbG8gRmFi
cmljZSwKPiAKPiBPbiBUdWUsIEZlYiAxMiwgMjAxOSBhdCAwOTozMTozN0FNICswMTAwLCBGYWJy
aWNlIEdhc25pZXIgd3JvdGU6Cj4+IE9uIDIvMTEvMTkgODowNiBQTSwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAxMSwgMjAxOSBhdCAwNToxMjowMlBNICswMTAwLCBG
YWJyaWNlIEdhc25pZXIgd3JvdGU6Cj4+Pj4gQEAgLTk0Myw2ICs5NTAsOCBAQCBzdHJ1Y3QgcHdt
X2RldmljZSAqZGV2bV9vZl9wd21fZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmlj
ZV9ub2RlICpucCwKPj4+PiAgCWlmICghSVNfRVJSKHB3bSkpIHsKPj4+PiAgCQkqcHRyID0gcHdt
Owo+Pj4+ICAJCWRldnJlc19hZGQoZGV2LCBwdHIpOwo+Pj4+ICsJCWRldmljZV9saW5rX2FkZChk
ZXYsIHB3bS0+Y2hpcC0+ZGV2LAo+Pj4+ICsJCQkJRExfRkxBR19BVVRPUkVNT1ZFX0NPTlNVTUVS
KTsKPj4+Cj4+PiBJTUhPIGl0J3Mgc3VycHJpc2luZyB0aGF0IGRldm1fb2ZfcHdtX2dldCgpIGRv
ZXMgbW9yZSB0aGFuIG9mX3B3bV9nZXQoKQo+Pj4gKyBkZXZyZXMgc3R1ZmYuIEknZCBwdXQgZGV2
aWNlX2xpbmtfYWRkKCkgaW50byBvZl9wd21fZ2V0KCkuCj4+Cj4+IEhpIFV3ZSwKPj4KPj4gSSBh
bHNvIGFncmVlIHdpdGggdGhpcy4gQnV0IEkgdGhpbmsgdGhpcyBpbXBsaWVzIG1vZGlmeWluZyB0
aGUgQVBJIGZvcgo+PiBvZl9wd21fZ2V0KCk6Cj4+ICAvKioKPj4gICAqIG9mX3B3bV9nZXQoKSAt
IHJlcXVlc3QgYSBQV00gdmlhIHRoZSBQV00gZnJhbWV3b3JrCj4+ICsgKiBAZGV2OiBkZXZpY2Ug
Zm9yIFBXTSBjb25zdW1lcgo+PiAgICogQG5wOiBkZXZpY2Ugbm9kZSB0byBnZXQgdGhlIFBXTSBm
cm9tCj4+ICAgKiBAY29uX2lkOiBjb25zdW1lciBuYW1lCj4+Cj4+IEl0IHNlZW1zIHRoZXJlIGFy
ZW4ndCBtdWNoIG9mX3B3bV9nZXQoKSB1c2VycyBjdXJyZW50bHkuCj4+IERvZXMgdGhpcyBsb29r
IHNlbnNpYmxlID8KPiAKPiBJbiBteSBleWVzIHRoaXMgbG9va3Mgc2Vuc2libGUsIHllcy4KCkhl
bGxvIFV3ZSwKCkkganVzdCBzZW50IGEgdjMgd2l0aCB0aGF0IGNoYW5nZSwKClRoYW5rcwpGYWJy
aWNlCj4gCj4gQmVzdCByZWdhcmRzCj4gVXdlCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
